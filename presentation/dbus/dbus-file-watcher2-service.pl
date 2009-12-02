#!/usr/bin/perl


=head1 NAME

dbus-file-watcher2-service.pl - Monitor files and wait for D-Bus clients.

=head1 DESCRIPTION

This program is a very basic file monitor. It monitors folders for files and
prints a log message each time that there's a change in the folder.

This program is a dumber version of dbus-file-watcher-service.pl. The main
difference, besides the lower functionality, is that it uses the reactor
L<Net::DBus::Reactor> for the main loop.

Feel free to modify and to comment on this program.

=head1 SYNOPSiS

dbus-file-watcher2-service.pl [FOLDER]...

Where I<FOLDER> is a folder.

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut


use FindBin;
use lib "$FindBin::Bin";


# From a daemon
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
		service => 'org.example.FileWatcher2'
	}
);


# List for events of the FileWatcher
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
