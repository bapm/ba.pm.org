package DBus::Test;

use strict;
use warnings;

use Net::DBus::Exporter qw(org.example.Test);

use base qw(Net::DBus::Object);

use base 'Class::Accessor';
__PACKAGE__->mk_accessors(
	qw(
		counter
	)
);


sub new {
	my $class = shift;
	my $service = shift;

	my $self = $class->SUPER::new($service, "/org/example/Test");

	bless $self, $class;
	$self->counter(0);

	return $self;
}


dbus_method("Hello", ["string"], ["string"]);

sub Hello {
	my $self = shift;
	my $name = shift;

	my $counter = $self->counter + 1;
	$self->counter($counter);

	print "($counter) Got a request\n";

	return "Said hello to $name ($counter)";
}

dbus_signal("Wakeup", ["string"]);

# A true value
1;
