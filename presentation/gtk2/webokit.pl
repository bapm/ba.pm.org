#!/usr/bin/perl

use strict;
use warnings;

=head1 NAME

webokit.pl - A lamentable nonaward-winnning web browser

=head1 DESCRIPTION

A very simple web browser that embeds the WebKit web browser engine
(Konqueror/Safari) and uses glade for the layout.

This web browser is quite limited an lacks a lot of functionality but it's code
base is very small. Less lines of code, less bugs!

=head1 COPYRIGHT

This program was inpired by pumzilla.pl

Copyright (C) 2008 Emmanuel Rodriguez

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available.

=cut


#
# Web browser using MozEmbed and Glade.
#

use Glib qw/TRUE FALSE/;
use Gtk2 '-init';
use Gtk2::GladeXML;
use Gtk2::WebKit;

my $GLADE;
my $WEBKIT;

exit main();

sub main {

  # Create the widgets from a glade definition file
	$GLADE = Gtk2::GladeXML->new('browser.glade');
	
	# Registered the callbacks assigned to the widgets with the functions
	# available within this package
  $GLADE->signal_autoconnect_from_package(__PACKAGE__);

	# Create the WebKit widget (the part that shows the web pages)
	$WEBKIT = Gtk2::WebKit::WebView->new();
	
	# Add the WebKit widget to the main application. The program assumes that the
	# glade files has a container named 'main' that can accept a widget.
	my $main = $GLADE->get_widget('main');
	# We must wrap the WebKit widget in a scroll in order to provide it scrollbars
	my $scroll = Gtk2::ScrolledWindow->new();
	$scroll->set_shadow_type('in');
	$scroll->set_policy('automatic', 'automatic');
	$scroll->add($WEBKIT);
	$scroll->show_all();
	$main->add($scroll);

	$main->get_toplevel->set_title('WeboKit');
	
	# Start the main loop
	Gtk2->main();
	
	return 0;
}


sub callback_quit {
	Gtk2->main_quit();
}

sub callback_go_back {
	$WEBKIT->go_back();
}

sub callback_go_forward {
	$WEBKIT->go_forward();
}

sub callback_refresh {
	$WEBKIT->reload();
}

sub callback_stop {
	$WEBKIT->stop_loading();
}

sub callback_go_home {
	my ($name) = @_;
	$GLADE->get_widget('url')->set_text('http://bratislava.pm.org/');
	callback_go_to_url();
}

sub callback_go_to_url {
	my $url = $GLADE->get_widget('url')->get_text();
	return unless $url =~ /\S/;
	$WEBKIT->open($url);
}
