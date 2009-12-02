package DBus::FileWatcher;

=head1 NAME

DBus::FileWatcher - Simple file watcher D-Bus service.

=head1 SYNOPSIS

This module can be used in the following fashion in order to create a service:

	# To create a service
	use Net::DBus;
	use Net::DBus::Reactor;
	use Net::DBus::Callback;
	
	use DBus::FileWatcher;
	
	# Create an event loop
	my $reactor = Net::DBus::Reactor->main();
	
	# Get a D-Bus instance and create the FileWatcher service
	my $bus = Net::DBus->session();
	my $file_watcher = DBus::FileWatcher->new(
		{
			bus => $bus,
			callback => \&file_event,
			shutdown => sub { $reactor->shutdown() },
		}
	);
	
	
	# Listen for events of the FileWatcher.
	# NOTE: This is MANDATORY otherwise nothing will be monitored!
	$reactor->add_read(
		$file_watcher->inotify->fileno,
		Net::DBus::Callback->new(
			method => sub {
				$file_watcher->inotify->poll(),
			}
		)
	);
	
	
	# Start the event loop
	print "Starting main loop\n";
	$reactor->run();
	print "End of program\n";
	
	
	sub file_event {
		my ($filename) = @_;
		print "Event for $filename\n";
	}

A client will simply use the service in the following way:

	use Net::DBus;
	my $file_watcher = Net::DBus->session
		->get_service("org.example.FileWatcher")
		->get_object("/org/example/FileWatcher")
	;
	
	$file_watcher->MonitorFolder("/tmp");
	
	my $folders = $file_watcher->GetMonitoredFolders();
	foreach my $folder (@{ $folders }) {
		print $folder, "\n";
	}

=head1 DESCRIPTION

This module provides a simple file monitor daemon. It can inspect various
folders simultaneously. When there's a file change within one of the folders
inspected a callback will be invoked.

This module uses Inotify for the monitoring, thus the file changes should be
reported instantaneously.

=head1 ATTRIBUTES

The following attributes are available:

=head2 inotify

Instance to the Inotify handle been used for monitoring the folders. This
attribute should be only used in order to register a watch in the main event
loop by using the C<fileno> attribute provided by Inotify. The event callback
registered in the main event loop should invoke C<$file_watch->inotify->poll()>.

=head1 METHODS

This D-Bus service offers the following methods:

=cut


use strict;
use warnings;

# D-Bus service setup
use Net::DBus::Exporter qw(org.example.FileWatcher);
use base qw(Net::DBus::Object);

use Data::Dumper;
use Carp;
use Linux::Inotify2;


use base 'Class::Accessor';
__PACKAGE__->mk_accessors(
	qw(
		inotify
		monitors
		callback
		callback_shutdown
	)
);



=head2 new

Constructor, creates a new instance of the file watcher. This method will also
export the D-Bus service, thus this constructor acts as a singleton.

B<IMPORTANT>: This module requires that the caller starts an event loop and that
that event loop monitors the status of Inotify and it polls the pending events.
This is done differently depending on the event loop been used.

For an event loop through the Net::DBus::Reactor this is done with:

	# List for events of the FileWatcher
	$reactor->add_read(
		$file_watcher->inotify->fileno,
		Net::DBus::Callback->new(
			method => sub {
				$file_watcher->inotify->poll(),
			}
		)
	);

While for an event loop using Glib or any other derivate of it such as GTK2,
GStreamer or Clutter the events are polled with:

	# Listen to inotify events, without this the FileWatcher daemon will be useless
	Glib::IO->add_watch(
		$file_watcher->inotify->fileno, 
		in => sub { $file_watcher->inotify->poll }
	);

Parameters:

	\%args with the following keys:
		dbus => an instance of Net::DBus (mandatory)
		callback => code ref that will be invoked for each change (mandatory)
		shutdown => callback invoked when the application whould shutdown (optional)
		service  => the name of the service (defaults to org.example.FileWatcher)

=cut

sub new {
	my $class = shift;

	# Parse the arguments
	my ($args) = @_;
	croak "Arguments must be an hash ref" unless ref $args eq 'HASH';

	my $bus = $args->{bus};
	croak "Argument bus must be an instance of Net::DBus" unless $bus and $bus->isa('Net::DBus');

	my $callback = $args->{callback};
	croak "Argument callback must be code reference" unless ref $callback eq 'CODE';

	my $shutdown;
	if (exists $args->{shutdown}) {
		$shutdown = $args->{shutdown};
		croak "Argument shutdown must be code reference" unless ref $shutdown eq 'CODE';
	}

	my $service_name = "org.example.FileWatcher";
	if (exists $args->{service}) {
		$service_name = $args->{service};
	}


	# D-Bus Object constructor
	my $service = $bus->export_service($service_name);
	my $self = $class->SUPER::new($service, "/org/example/FileWatcher");
	bless $self, $class;

	
	my $inotify = Linux::Inotify2->new() or croak "Can't start inotify because $!";
	$self->inotify($inotify);
	$self->monitors({});

	$self->callback($callback);
	$self->callback_shutdown($shutdown);

	return $self;
}



=head2 MonitorFolder

Adds a folder to the monitoring list.

Throws an exception if the folder is already being monitored.

Usage:
	
	$file_watcher->MonitorFolder("/tmp");

=cut
dbus_method("MonitorFolder", ["string"], []);
sub MonitorFolder {
	my $self = shift;
	my $folder = shift;
# FIXME get the absolute path of the folder and remove the trailing /
	if ($self->monitors->{$folder}) {
		die "Folder $folder is already monitored\n";
	}

	# Register the folders to watch with inotify
	my $watch = $self->inotify->watch(
		$folder,
		IN_CREATE | IN_MOVE | IN_MODIFY, 
		sub { 
			my ($event) = @_;
# FIXME listen for IN_DELETE_SELF and remove the folder watch.
# FIXEM listen for IN_MOVE_SELF and remove the folder watch.
			$self->callback->($event->fullname); 
		},
	) or die "Can't watch $folder through inotify because $!\n";

	$self->monitors->{$folder} = $watch;

	print "Monitoring folder $folder\n";
}



=head2 GetMonitoredFolders

Returns the folders being currently monitored.

Usage:
	
	my $folders = $file_watcher->GetMonitoredFolders();
	foreach my $folder (@{ $folders }) {
		print "Monitoring $folder\n";
	}

=cut

dbus_method("GetMonitoredFolders", [], [["array", "string"]]);
sub GetMonitoredFolders {
	my $self = shift;
	return [ keys %{ $self->monitors } ];
}



=head2 UnmonitorFolder

Removes a folder from the monitoring list.

Throws an exception if the folder to remove is not being monitored.

Usage:
	
	$file_watcher->UnmonitorFolder("/tmp");

=cut

dbus_method("UnmonitorFolder", ["string"], []);
sub UnmonitorFolder {
	my $self = shift;
	my ($folder) = @_;
	
	if (my $watch = delete $self->monitors->{$folder}) {
		$watch->cancel();
		print "Unmonitoring the folder $folder\n";
	}
	else {
		die "Folder $folder not found\n";
	}
}



=head2 Shutdown

Shutdowns the service.

Throws an exception if there's no shutdown callback.

=cut

dbus_method("Shutdown", [], []);
sub Shutdown {
	my $self = shift;

	my $shutdown = $self->callback_shutdown;
	if (ref $shutdown eq 'CODE') {
		print "Shutdown\n";
		$shutdown->();
	}
	else {
		die "There is no shutdown method\n";
	}
}


# A true value
1;

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=cut
