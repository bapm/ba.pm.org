//
// Sample program that shows how to create a window with a greeting.
// 
// Copyright (C) 2008 Emmanuel Rodriguez
//
// This program is free software; you can redistribute it and/or modify it under
// the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
// any later version of Perl 5 you may have available.
//
// Compile with
// gcc -o hello-world -g -O2 -std=c99 `pkg-config --cflags --libs gtk+-2.0` hello-world.c
//

#include <gtk/gtk.h>

int main(int argc, char *argv[] ) {

	gtk_init(&argc, &argv);

	GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
	GtkWidget *label = gtk_label_new("Hello World");
	
	gtk_container_add(GTK_CONTAINER(window), label);
	
	gtk_widget_show_all(window);

	// The main event loop
	gtk_main();
	
	return 0;
}
