#!/usr/bin/perl

=head1 NAME

dbus-pidgin-enable-account.pl - Enable a Pidgin account through D-Bus.

=head1 DESCRIPTION

This program will enable the given Pidgin account.

=head1 SYNOPSIS

dbus-pidgin-enable-account.pl ACCOUNT PROTOCOL

Where I<ACCOUNT> is the name of a Pidgin account and I<PROTOCOL> the protocol
used by the account.

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
	
	my ($account_protocol, $account_name) = @ARGV;
	$account_protocol ||= 'XMPP'; # Jabber uses XMPP
	$account_name ||= 'emmanuel.rodriguez' . '@' . 'gmail.com';
	my $account_regexp = qr/^\Q$account_name\E/;

	
	# Connect to Pidgin through D-Bus
	my $pidgin = Net::DBus->session
		->get_service('im.pidgin.purple.PurpleService')
		->get_object('/im/pidgin/purple/PurpleObject')
	;
	

	# We need the UI name for the calls to PurpleAccountGetEnabled()
	my $ui = $pidgin->PurpleCoreGetUi();


	# Loop through all accounts available in Pidgin
	my $accounts = $pidgin->PurpleAccountsGetAll();
	my $wanted_account;
	foreach my $account (@{ $accounts }) {


		# For each account we need the protocol used, the name of the account and if
		# it's already enabled
		my $protocol = $pidgin->PurpleAccountGetProtocolName($account);
		my $name = $pidgin->PurpleAccountGetUsername($account);
		my $enabled = $pidgin->PurpleAccountGetEnabled($account, $ui);
		
		if (!$enabled and ($protocol eq $account_protocol) and ($name =~ /$account_regexp/)) {
			
			# The account has been found but the loop will go on. This way all accounts
			# get printed
			$wanted_account = {
				id       => $account,
				name     => $name,
				protocol => $protocol,
			};
		}
		
		printf "%-4s %s %s\n", $protocol, $name, $enabled ? 'enabled' : 'disabled';
	}


	# Enable the account
	if ($wanted_account) {
		print "Enabling account $wanted_account->{name} through protocol $wanted_account->{protocol}!\n";
		$pidgin->PurpleAccountSetEnabled($wanted_account->{id}, $ui, 1);
	}

	return 0;
}
