#!/usr/bin/perl

=head1 NAME

dbus-pidgin-list-accounts.pl - List the accounts available in Pidgin.

=head1 DESCRIPTION

This program will list the accounts Pidgin.

=head1 SYNOPSIS

dbus-pidgin-list-accounts.pl

=head1 AUTHOR

Emmanuel Rodriguez E<lt>potyl@cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2008 by Emmanuel Rodriguez

=cut

use strict;
use warnings;

use Net::DBus;
use Data::Dumper;

exit main();

sub main {
	
	# Connect to Pidgin through D-Bus
	my $pidgin = Net::DBus->session
		->get_service('im.pidgin.purple.PurpleService')
		->get_object('/im/pidgin/purple/PurpleObject')
	;


	# Loop through all accounts available in Pidgin
	my $accounts = $pidgin->PurpleAccountsGetAll();
	foreach my $account (@{ $accounts }) {

		# For each account we want the protocol used and the name of the account
		my $protocol = $pidgin->PurpleAccountGetProtocolName($account);
		my $name = $pidgin->PurpleAccountGetUsername($account);
		
		printf "%-4s %s\n", $protocol, $name;
	}

	return 0;
}
