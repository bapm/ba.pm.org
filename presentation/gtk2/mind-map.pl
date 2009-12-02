#!/usr/bin/perl

=head1 NAME

mind-map.pl - Mind map of perl module's usage.

=head SYNOPSIS

	mind-map.pl file

Where I<file> is a perl script or the path to a perl module.

=head1 DESCRIPTION

Sample program that shows a mind map of the modules used by a perl application.

=head1 COPYRIGHT

Copyright (C) 2008 Emmanuel Rodriguez

=head1 LICENSE

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
any later version of Perl 5 you may have available.

=cut

use strict;
use warnings;

use Glib qw(TRUE FALSE);
use Gtk2 '-init';
use Gtk2::Ex::MindMapView;
use Gtk2::Ex::MindMapView::ItemFactory;

use PPI;
use File::Basename qw(fileparse basename);
use Data::Dumper;


# Cache of items already created
my %ITEMS_CACHE = ();

# Item's factory
my $ITEMS_FACTORY;


exit main();


sub main {

	die "Usage: file\n" unless @ARGV;
	my ($file) = @ARGV;

	# Create the main widgets
	my $window = Gtk2::Window->new;
	my $mind_view = Gtk2::Ex::MindMapView->new(
		aa => 1, # Enable anti-aliasing
	);
	my ($width, $height) = (10_000, 10_000);
	$mind_view->set_scroll_region(
		(-$width, -$height),
		($width, $height),
	);


	# Package the widgets and show them (they will not appear yet)
	my $scroll = Gtk2::ScrolledWindow->new();
	$scroll->add($mind_view);
	$window->add($scroll);
	$window->set_default_size(600, 400);
	$window->show_all(); # Instructs the widget that it will have to be shown


	# Make sure that we finish the main event loop when the main window is closed
	$window->signal_connect(delete_event => sub {
		Gtk2->main_quit();
		return 0;
	});
	
	
	# Populate the mind map
	$ITEMS_FACTORY = Gtk2::Ex::MindMapView::ItemFactory->new(view => $mind_view);
	my $root = create_mind_map(basename($file), $file);
	$mind_view->layout();


	# Scroll the to the center (or close enough to it)
	foreach my $adjustment ($scroll->get_hadjustment, $scroll->get_vadjustment) {
		my $center = ($adjustment->upper - $adjustment->lower)/2;
		$adjustment->value($center);
	}

	# Start the main event loop
	Gtk2->main();
	
	return 0;
}


# Creates the mind map recursively
sub create_mind_map {
	my ($label, $file, $root, $type, $level) = @_;
	$type ||= 'root';
	$level ||=0;
	my $mind_view = $ITEMS_FACTORY->{view};


	# Check if the item was already created
	my $done = $ITEMS_CACHE{$file};
	my $item = create_item($label, $type);
	if (! $done) {
		$ITEMS_CACHE{$file} = 1;
		print "Processing file $file\n";
	
		# Find the dependencies
		my %seen = ();
		my $document = PPI::Document->new($file);
		my $includes = $document->find('PPI::Statement::Include');
		foreach my $include (@{ $includes }) {

			#next if $include->pragma;
			my $module = $include->module or next;
			
			# Some modules use multiple requires of the same module!
			next if $seen{$module};
			$seen{$module} = 1;


			# Find the full path of the module
			my $inc = "$module.pm";
			$inc =~ s,::,/,g;
			my $module_file = $INC{$inc};
			if (! $module_file) {
				eval "use $module;";
				if (my $error = $@) {
					warn "Failed to load $module because: $error";
					next;
				}
				
				$module_file = $INC{$inc};
			}

			$type = $include->pragma ? 'pragma' : 'module';
			create_mind_map($module, $module_file, $item, $type, $level + 1);
		}
	}


	# Add the item to the view
	if (defined $root) {
		$mind_view->add_item($root, $item);
	}
	else {
		$mind_view->add_item($item);
		$root = $item;
	}

	return $root;
}


# Creates a single item
sub create_item {
	my ($label, $type) = @_;

	my %args = (
		border  => 'Gtk2::Ex::MindMapView::Border::RoundedRect',
		content => 'Gtk2::Ex::MindMapView::Content::EllipsisText',
		text    => $label,
	);	

	
	if ($type eq 'root') {
		$args{border} = 'Gtk2::Ex::MindMapView::Border::Rectangle';
	}
	elsif ($type eq 'pragma') {
		$args{text_color_gdk} = Gtk2::Gdk::Color->parse('darkred');
	}


	# Create a new item node
	my $item = $ITEMS_FACTORY->create_item(%args);
	return $item;
}
