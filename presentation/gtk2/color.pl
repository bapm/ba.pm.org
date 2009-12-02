#!/usr/bin/perl

=head1 NAME

color.pl - A simple color picker available in the system tray

=head1 DESCRIPTION

A very simple color picker that's always present in the system tray. When the
color picker icon is clicked a color choser dialog is toggled. Once a color is
chosen the color is copied into the clipboard and available to be pasted. The
color is copied to both the primary (middle click) and the selection cliboard
(Control-c).

B<NOTE>: This program works only with newer versions of GTK2, for instance it
doesn't work under Debian Etch where the package Gtk2::StatusIcon isn't
available. Under such systems use the alternative program F<color-debian.pl>.

=head1 COPYRIGHT

Copyright (C) 2008 Emmanuel Rodriguez

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available.

=cut

use strict;
use warnings;

#
# Simple color chooser that lies in the system tray. When a color is chosen it's
# automatically available in the clipboard as an HTML value (ex: #FF0000)
#

use Glib qw/TRUE FALSE/;
use Gtk2 '-init';

exit main();

sub main {

	
	####
	# The main widgets
	
	# The main window
	my $window = Gtk2::Window->new('toplevel');
	$window->set_title("HTML Color");	
	$window->set_icon(
		$window->render_icon('gtk-color-picker', 'dialog')
	);
	
	# The color chooser
	my $color_selection = Gtk2::ColorSelection->new();
	$color_selection->show_all();
	
	$window->add($color_selection);

	# Create a system tray icon
	my $tray = Gtk2::StatusIcon->new_from_stock('gtk-color-picker');

	
	#####
	# Set the callbacks
	
	# Hide the main window
	$window->signal_connect(delete_event =>
		sub {
			$window->hide();
			return TRUE;
		}
	);

	# Set the HTML value of the color selected
	$color_selection->signal_connect(color_changed => \&color_changed);
	
	# Show/hide the main window when the system tray icon is clicked
	$tray->signal_connect(activate => 
		sub {
			if ($window->visible) {
				$window->hide();
			}
			else {
				$window->present();
			}
		}
	);

	# Start the main loop
	Gtk2->main();
	
	return 0;
}


sub color_changed {
	my ($color_selection) = @_;

	# Get the color's HTML value
	my $color = $color_selection->get_current_color();
	my $html_value = $color_selection->palette_to_string($color);

	# Update the clipboards with the HTML value
	my @selections = (
		Gtk2::Gdk->SELECTION_CLIPBOARD, 
		Gtk2::Gdk->SELECTION_PRIMARY,
	);
	foreach my $selection (@selections) {
		my $clipboard = Gtk2::Clipboard->get($selection);
		$clipboard->set_text($html_value);
	}
		
	return TRUE;
}
