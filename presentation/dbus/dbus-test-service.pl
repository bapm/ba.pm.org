#!/usr/bin/perl

=head1 NAME

dbus-test-service.pl - Publish a test service through D-Bus.

=head1 DESCRIPTION

This program publishes a custom made service through D-Bus.

=head1 SYNOPSIS

dbus-test-service.pl

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Net::DBus;
use Net::DBus::Reactor;
use DBus::Test;

exit main();

sub main {

	# Request a service name for the object to be shared
	my $service = Net::DBus->session->export_service("org.example.Test");

	# Export an object within the service
	my $object = DBus::Test->new($service);


	# Start a main loop and wait for incoming requests
	my $reactor = Net::DBus::Reactor->main();


	# Fire the "Wakeup" signal, the signal is fired only once, so be fast!
	my $timer;
	$timer = $reactor->add_timeout(
		5_000,
		Net::DBus::Callback->new(
			method => sub {
				print "Waking up clients\n";
				# Fire the signal!
				$object->emit_signal("Wakeup", "It's enough");
				
				# If the timeout is removed, then the signal is emited only once
				# Commment this line and the signal will be periodic
				$reactor->remove_timeout($timer);
			},
		)
	);


	# Start a main loop
	$reactor->run();


	return 0;
}
