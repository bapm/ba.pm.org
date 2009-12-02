#!/usr/bin/perl

=head1 NAME

term-top.pl - Run top within a terminal

=head1 DESCRIPTION

Sample program that embeds a terminal (libvte) and runs 'top'. The terminal
widget is disabled and can't receive any focus. Although end user interaction
is allowed through some buttons provided at the top.

This program shows that any arbitrary command can be embeded in the terminal
and that interaction with the terminal doesn't have to be exclusively through
the keyboard.

=head1 COPYRIGHT

This program is a modified version of the documentation provided by
Gnome2::Vte.

Copyright (C) 2003-2006 by the gtk2-perl team

Copyright (C) 2008 Emmanuel Rodriguez

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available.

=cut

use warnings;
use strict;

use Glib qw(TRUE FALSE);
use Gtk2 -init;
use Gnome2::Vte;

exit main();

sub main {

	# create things
	my $window = Gtk2::Window->new();
	my $scrollbar = Gtk2::VScrollbar->new();
	my $terminal = Gnome2::Vte::Terminal->new();
	
	# Disable input events (can't write into the terminal)
	$terminal->set_sensitive(FALSE);
	
	# set up scrolling
	$scrollbar->set_adjustment($terminal->get_adjustment);
	
	# lay 'em out
	my $hbox = Gtk2::HBox->new();
	$hbox->pack_start($terminal, TRUE, TRUE, 0);
	$hbox->pack_start($scrollbar, FALSE, FALSE, 0);
	
	my $vbox = Gtk2::VBox->new();
	my $control_buttons = create_control_buttons($terminal);
	$vbox->pack_start($control_buttons, FALSE, FALSE, 0);
	$vbox->pack_start($hbox, TRUE, TRUE, 0);
	
	$window->add($vbox);
	$window->show_all();

	# Run a command (top in this case)
	# Parameters:
	#  - First the command to execute
	#  - Second an array ref with the arguments to pass to the command (@ARGV)
	#    NOTE: these arguments are in fact the 'argv' pointer passed to the main
	#          function (as in a C program) thus argv[0] is expected to be the
	#          name of the program (just like in C). The actual arguments to pass
	#          have to be after the program name.
	$terminal->fork_command('/usr/bin/top', ['top'], undef, '/tmp', FALSE, FALSE, FALSE);
	
	# hook 'em up
	$terminal->signal_connect(child_exited => sub { Gtk2->main_quit });
	$window->signal_connect(delete_event => sub { Gtk2->main_quit; FALSE });
	
	# turn 'em loose
	Gtk2->main();
	
	return 0;
}


sub create_control_buttons {
	my ($terminal) = @_;
	my $hbox = Gtk2::HBox->new();

	add_button($terminal, $hbox, Refresh => ' ');
	add_button($terminal, $hbox, Quit => 'q');
	
	return $hbox;
}


sub add_button {
	my ($terminal, $box, $text, $action) = @_;

	my $button = Gtk2::Button->new($text);

	my $callback = sub {
		# Send some characters to the terminal 
		$terminal->feed_child($action);
	};
	$button->signal_connect(activate => $callback);
	$button->signal_connect(clicked => $callback);

	$box->pack_start($button, FALSE, FALSE, 0);
}
