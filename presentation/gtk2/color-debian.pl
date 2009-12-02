#!/usr/bin/perl

=head1 NAME

color-debian.pl - Yet another simple color picker available in the system tray

=head1 DESCRIPTION

A very simple color picker that's always present in the system tray. When the
color picker icon is clicked a color choser dialog is toggled. Once a color is
chosen the color is copied into the clipboard and available to be pasted. The
color is copied to both the primary (middle click) and the selection cliboard
(Control-c).

B<NOTE>: This program works well with old versions of GTK2 where the package
Gtk2::StatusIcon isn't available. With newer versions of GTK2 the alternative
program F<color.pl> should be used as it's code base is smaller and the main
functionality is integrated into GTK2's core.

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
use Gtk2::TrayIcon;
exit main();

sub main {

	
	####
	# The main widgets
	
	# The main window
	my $window = Gtk2::Window->new('toplevel');
	$window->set_title("HTML Color");	
	$window->set_icon($window->render_icon('gtk-color-picker', 'dialog'));
	
	# The color chooser
	my $color_selection = Gtk2::ColorSelection->new();
	$color_selection->show_all();
	
	$window->add($color_selection);

	# Create a system tray icon with our icon.
	my $icon = Gtk2::Image->new_from_stock('gtk-color-picker', 'menu');


  # Because an icon can't receive events it has to be wrapped into an event box
	my $event_box = Gtk2::EventBox->new();
	$event_box->add($icon);
	
	# Add the event box (which includes a nice icon into the system tray)
	my $tray = Gtk2::TrayIcon->new($window->get_title);
	$tray->add($event_box);
	$tray->show_all();

	
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
	
	# Show/hide the main window
	$event_box->signal_connect(button_press_event =>
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
