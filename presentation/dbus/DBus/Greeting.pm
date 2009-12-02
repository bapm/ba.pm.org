package DBus::Greeting;

# Invoke the exporter utility and specify the default interface name
use Net::DBus::Exporter 'org.example.Greeting';

# Become a D-Bus object
use base 'Net::DBus::Object';

sub new {
	my ($class, $service) = @_;
	# Call the parent's constructor with a service and a path for this instance
	my $self = $class->SUPER::new($service, '/org/example/Greeting');
	bless $self, $class;
}

# Register a method named "Hello" that takes a string as argument
# and returns a string
dbus_method('Hello', ['string'], ['string']);
sub Hello {
	my $self = shift;
	my ($name) = @_;
	print "Called with $name\n";
	return "Hello $name";
}
1;
