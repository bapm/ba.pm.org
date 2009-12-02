#!/usr/bin/perl

=head1 NAME

dbus-list-services.pl - List the services available in D-Bus.

=head1 DESCRIPTION

This program list the services registered in D-Bus. It uses the introspection
mechanism defined in D-Bus for listing all services.

=head1 SYNOPSIS

dbus-list-services.pl [OPTION]

Options: 

  --system   use the system bus.
  --session  use the session bus.

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Net::DBus;
use Data::Dumper;
use Getopt::Long qw(:config auto_help pass_through);

exit main();

sub main {
	
	my $use_session = 1;
	GetOptions(
		'system'  => sub {$use_session = 0},
		'session' => sub {$use_session = 1},
	);
	
	# Get the D-Bus object
	my $bus = $use_session ? Net::DBus->session : Net::DBus->system;
	my $dbus = $bus
		->get_service('org.freedesktop.DBus')
		->get_object('/org/freedesktop/DBus')
		or die "Can't get the DBus instance"		
	;

	# Get the list of services offered by the bus
	my $names = $dbus->ListNames();
	foreach my $name (sort @{ $names }) {
		# Discard all unnamed services (these are the D-Bus clients)
		next if $name =~ /^:\d+\.\d+$/;
		print "$name\n";
	}

	return 0;
}
