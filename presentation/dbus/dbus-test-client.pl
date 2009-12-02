#!/usr/bin/perl

=head1 NAME

dbus-test-client.pl - Connect to the test service through D-Bus.

=head1 DESCRIPTION

This program communicates with the D-Bus test service.

=head1 SYNOPSIS

dbus-test-client.pl

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Net::DBus;
use Net::DBus::Reactor;

exit main();

sub main {
	
	# Get the D-Bus instance to the test object
	my $test = Net::DBus->session
		->get_service('org.example.Test')
		->get_object('/org/example/Test')
	;


	# Invoke a method on the test object
	my $greeting = $test->Hello('emo');
	print $greeting, "\n";


	# Tell the object to let us know when it's time to wake up
	# This requires that we start an even loop.
	$test->connect_to_signal('Wakeup', \&Wakeup);

	
	# Use the Reactor for the event loop
	my $reactor = Net::DBus::Reactor->main();

	# Give the service 5 a few seconds to live
	my $timer = $reactor->add_timeout(
		6_000,
		Net::DBus::Callback->new(
			method => sub {
				$reactor->shutdown();
				print "Shutdown\n";
			}
		)
	);

	# Start the main loop
	$reactor->run();

	return 0;
}


sub Wakeup {
	my ($text) = @_;
	print "Wakeup!!! $text\n";
}
