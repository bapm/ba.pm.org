#!/usr/bin/perl

=head1 NAME

terminal.pl - Run a terminal with custom actions

=head1 DESCRIPTION

Sample program that embeds a terminal (libvte) and adds some custom buttons. The
terminal is fully usable and the top buttons are used to execute some simple
commands in the terminal.

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

use strict;
use Glib qw(TRUE FALSE);
use Gtk2 -init;
use Gnome2::Vte;

# create things
my $window = Gtk2::Window->new;
my $scrollbar = Gtk2::VScrollbar->new;
my $terminal = Gnome2::Vte::Terminal->new;

# set up scrolling
$scrollbar->set_adjustment ($terminal->get_adjustment);

# lay 'em out
my $hbox = Gtk2::HBox->new;
$hbox->pack_start ($terminal, TRUE, TRUE, 0);
$hbox->pack_start ($scrollbar, FALSE, FALSE, 0);

my $control_buttons = create_control_buttons($terminal);
my $vbox = Gtk2::VBox->new();
$vbox->pack_start($control_buttons, FALSE, FALSE, 0);
$vbox->pack_start($hbox, TRUE, TRUE, 0);

$window->add($vbox);
$window->show_all;

# Start a normal shell
$terminal->fork_command(
	'/bin/bash', ['bash', '-login'], undef,
	'/tmp', FALSE, FALSE, FALSE
);

# hook 'em up
$terminal->signal_connect (child_exited => sub { Gtk2->main_quit });
$window->signal_connect (delete_event => sub { Gtk2->main_quit; FALSE });

# turn 'em loose
Gtk2->main;


sub create_control_buttons {
	my ($terminal) = @_;
	my $hbox = Gtk2::HBox->new();

	my $ls = Gtk2::Button->new('List');
	$ls->signal_connect(activate => \&callback_ls);
	$ls->signal_connect(clicked => \&callback_ls);
	$hbox->pack_start($ls, FALSE, FALSE, 0);


	my $home = Gtk2::Button->new('Home');
	$home->signal_connect(activate => \&callback_home);
	$home->signal_connect(clicked => \&callback_home);
	$hbox->pack_start($home, FALSE, FALSE, 0);

	
	return $hbox;
}


sub callback_ls {
	my ($button, $data) = @_;
	print "Doing ls\n";
	# Remember that the shell executes commands only after and enter!
	$terminal->feed_child("ls -al\n");
}


sub callback_home {
	my ($button, $data) = @_;
	print "Going home\n";
	$terminal->feed_child("cd\n");
}

