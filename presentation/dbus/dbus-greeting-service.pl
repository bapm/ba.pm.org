#!/usr/bin/perl

use strict;
use warnings;

use Net::DBus;
use Net::DBus::Reactor;
use DBus::Greeting;

# Request a service name for the object to be shared
my $service = Net::DBus->session->export_service('org.example.Greeting');

# Export an object to our service
my $object = DBus::Greeting->new($service);

# Start a main loop and wait for incoming requests
Net::DBus::Reactor->main->run();
