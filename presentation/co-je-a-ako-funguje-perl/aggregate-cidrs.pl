#!/usr/bin/perl

=head1 NAME

aggregate-cidrs.pl - print aggregated cidrs by location

=head1 USAGE

    aggregate-cidrs.pl CIDR_LIST_FILE.txt

=head1 DESCRIPTION

Script aggregates cird blocks passed from input into a bigger blocks. Input lines
can look like this:

    192.168.0.0/24
    192.168.1.0/24
    192.168.2.0/24
    192.168.3.0/24

or like this:

    192.168.0.0/24 outside
    192.168.1.0/24 outside
    192.168.2.0/24 outside
    192.168.3.0/24 work

in the later case it will aggregate per location set in the second column.

=cut

use strict;
use warnings;

our $VERSION = 0.01;

use Net::CIDR::Lite;

exit main();

sub main {
    # hash for storing cidrs per location
    my %cidrs;

    # loop through input lines
    while (my $line = <>) {
        # skip comments and empty lines
        next if ($line =~ m/^\#/xms);
        next if ($line =~ m/^\s*$/xms);

        # get cidr and location
        my ($cidr, $location) = split(/\s+/xms, $line);

        # set empty location if not set
        $location = q{}
            if not defined $location;

        # add current cidr to location cirds
        $cidrs{$location} ||= Net::CIDR::Lite->new;
        $cidrs{$location}->add_any($cidr);
    }

    # loop through locations
    foreach my $location ( sort keys %cidrs ) {
        # print all aggregated cidrs with location
        foreach my $cidr ($cidrs{$location}->list) {
            print "$cidr $location\n";
        }
    }

    return 0;
}

__END__

=head1 AUTHOR

Jozef Kutej

=cut
