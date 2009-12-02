#!/usr/bin/perl

=head1 NAME

hello-world.pl - Simple hello world

=head1 DESCRIPTION

Sample program that shows how to create a window with a greeting.

=head1 COPYRIGHT

Copyright (C) 2008 Emmanuel Rodriguez

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available.

=cut

use strict;
use warnings;

use Gtk2 '-init';

exit main();

sub main {

	# Create the main widgets
	my $window = Gtk2::Window->new;
	my $label = Gtk2::Label->new('Hello World!');

	# Package the widgets and show them (they will not appear yet)
	$window->add($label);
	$window->show_all(); # Instructs the widget that it will have to be shown

	# Make sure that we finish the main event loop when the main window is closed
	$window->signal_connect(delete_event => sub {
		Gtk2->main_quit();
		return 0;
		}
	);
	
	# Start the main event loop
	Gtk2->main();
	
	return 0;
}
