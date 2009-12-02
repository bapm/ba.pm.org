#!/usr/bin/perl

=head1 NAME

dbus-file-watcher-service.pl - Monitor files and wait for D-Bus clients.

=head1 DESCRIPTION

This program is a basic file monitor. It monitors folders for files and notifies
the end user each time that there's a change in the folder.

This program has no other purpose than to show how to use D-Bus within different
scenarios. At first, this program tries to behave as a daemon, thus it's event
based and uses a main loop. Secondly, it shows how to cooperate with other
frameworks (glib and inotify). Finally, the program shows how to perform
asynchronous D-Bus requests by accessing the service 
org.freedesktop.Notifications which provides popup dialogs in order to interact
with the end user.

Feel free to modify and to comment on this program.

=head1 SYNOPSiS

dbus-file-watcher-service.pl [FOLDER]...

Where I<FOLDER> is a folder.

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Data::Dumper;

use Glib;

use Net::DBus::GLib;
use Net::DBus qw(:typing);
use Net::DBus::Annotation qw(:call);

use FindBin;
use lib "$FindBin::Bin";

use DBus::FileWatcher;

# The notifications made to the user that haven't been answered so far
my %NOTIFICATION_IDS = ();


exit main();


sub main {
	
	my (@folders) = @ARGV;

	local $| = 1;

	# Prepare an event loop
	my $loop = Glib::MainLoop->new();

	# Create a D-Bus service
	my $bus = Net::DBus::GLib->session();


	# Get a Notification instance in order to send messaged to the end user through popups
	my $notifications = $bus
		->get_service("org.freedesktop.Notifications")
		->get_object("/org/freedesktop/Notifications", "org.freedesktop.Notifications")
	;
	$notifications->connect_to_signal('NotificationClosed', \&callback_notification_closed);
	$notifications->connect_to_signal('ActionInvoked', \&callback_notification_action);


	# Export the file watcher service
	my $file_watcher = DBus::FileWatcher->new(
		{
			bus => $bus,
			callback => sub {callback_inotify($notifications, @_)},
			shutdown => sub {$loop->quit()},
		}
	);
	
	# Listen to inotify events, without this the FileWatcher daemon will be useless!
	Glib::IO->add_watch($file_watcher->inotify->fileno, in => sub { $file_watcher->inotify->poll });

	
	
	# Monitor the folders passed in the command line
	foreach my $folder (@folders) {
		$file_watcher->MonitorFolder($folder);
	}


	# Start an event loop
	$loop->run();

	return 0;
}


#
# This callback is called each time that inotify detects that a file is created
# or modifed.
#
# Here we give the end user the possibility to open the file.
#
sub callback_inotify {
	my ($notifications, $filename) = @_;

	# Asynchronously ask for an user action
	my $async = $notifications->Notify(
		dbus_call_async,
		"File Watcher",
		0, # ID
		'',# Icon
		"File watcher", # Summary
		"A modification happened to the file $filename", # Body
		[
			open   => "Open",
			ignore => "Ignore",
		], # Actions
		{}, # Hints
		5_000 # Expiration
	);

	# Called when the notification is created
	$async->set_notify(
		sub {
			my ($id) = $async->get_result();
			# We need to remember which file is associated with which question
			$NOTIFICATION_IDS{$id} = $filename;
		}
	);
}


#
# This callback is called when the notification (popup dialog) is closed either
# because there was a timeout or the user cancelled the operation.
#
# Here we simply discard the notification entry as the user cancelled the
# request.
#
sub callback_notification_closed {
	my ($id, $reason) = @_;
	delete $NOTIFICATION_IDS{$id};
}


#
# This callback is called when the a button has been clicked in the notification
# (popup dialog).
#
# Here we open the file if the user requested it.
#
sub callback_notification_action {
	my ($id, $action) = @_;
	
	my $filename = delete $NOTIFICATION_IDS{$id};
	if (! defined $filename) {
		print "Can't find filename for notification id $id\n";
		return;
	}
	
	if ($action eq 'open' and -e $filename) {
		print "Open file $filename\n";
		system("xdg-open", $filename);
	}
}
