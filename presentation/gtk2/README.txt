Make sure that the following perl modules are installed:
	- Gtk2
	- Gtk2::GladeXML
	- Gtk2::TrayIcon
	- Gnome2::Vte (bundled)
	- Gnome2::MozEmbed (bundled)

Also install the command line utility zenity.

Under Debian/Ubuntu you can follow this easy and dirty instructions:

	sudo apt-get install libgtk2-perl libgtk2-gladexml-perl libvte-dev
	sudo apt-get install libgtk2-trayicon-perl libxul-dev zenity
	sudo apt-get build-dep libgtk2-perl
	sudo apt-get install build-essential

Then install Gnome2::Vte and Gnome2::MozEmbed manually with a classic:

	perl Makefile.PL && make && sudo make

Enjoy the sample code!
