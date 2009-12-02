#!/usr/bin/perl

=head1 NAME

dbus-file-watcher-client.pl - Communicate with the FileWatcher daemon.

=head1 DESCRIPTION

This program communicates with a custom made file watcher daemon through D-Bus
and invokes a command on the daemon.

=head1 SYNOPSIS

dbus-file-watcher-client.pl [OPTION]... command [folder]

Where command is:

	list           - list the folders being monitored.
	add folder     - adds a folder to be monitored.
	remove folder  - removes a folder from the monitoring list.
	shutdown       - shutdowns the monitoring daemon.
	help           - list the commands.

And OPTION can be:

	-s=SERVICE, --service=SERVICE  the D-Bus service to connect to, defaults to
	                               org.examle.FileWatcher
	-o=OBJECT,  --object=OBJECT,   the path of the object on which the methods
	                               will be invoked, defaults to 
	                               /org/example/FileWatcher

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Net::DBus;
use Getopt::Long qw(:config auto_help pass_through);
use Pod::Usage;

exit main();

sub main {
	
	# Argument parsing
	my $service = 'org.example.FileWatcher';
	my $object = '/org/example/FileWatcher';
	GetOptions(
		'service|s=s' => \$service,
		'object|o=s'  => \$object,
	);

	pod2usage(1) unless @ARGV;
	my ($command, $folder) = @ARGV;

	
	# Get the D-Bus instance to the FileWatcher service
	my $fileWatcher = Net::DBus->session
		->get_service($service)
		->get_object($object)
	;

	
	# Invoke the proper method on the D-Bus service
	if ($command eq 'list') {
		my $folders = $fileWatcher->GetMonitoredFolders();
		foreach my $folder (@{ $folders }) {
			print $folder, "\n";
		}
	}
	elsif ($command eq 'add') {
		$fileWatcher->MonitorFolder($folder);
	}
	elsif ($command eq 'remove') {
		$fileWatcher->UnmonitorFolder($folder);
	}
	elsif ($command eq 'shutdown') {
		$fileWatcher->Shutdown($folder);
	}
	elsif ($command eq 'help') {
		pod2usage(0);
	}
	else {
		die "Invalid command: $command\n";
	}

	return 0;
}
