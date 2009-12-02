#!/usr/bin/perl -T

=head1 NAME

send-feedback.cgi - CGI that sends email from posted feedback form

=head1 SYNOPSIS

in html:

	<form action="/cgi-bin/send-feedback.cgi" id="feedback_form" method="post">
		<fieldset>
			<span class="text label">
				<label for="name">Your name</label>
				<input name="name" type="text" id="name" size="25" />
			</span>
			<span class="text label">
				<label for="email">Tour email</label>
				<input name="email" type="text" id="email" size="25" />
			</span>
			<span class="text label">
				<label for="subject">Subject</label>
				<input name="subject" type="text" id="subject" size="25" />
			</span>
			<div class="doNotFillIn">
				<div class="text label">
					<label for="donotfillin">Don't fill in</label>
					<input name="donotfillin" type="text" id="dontfillin" size="25" />
				</div>
			</div>
			<span class="textarea label">
				<label for="message">Message</label>
				<textarea name="message" cols="40" id="message" rows="5"></textarea>
			</span>
			<span class="submit">
				<input name="submit" type="submit" value="Submit" />
			</span>
		</fieldset>
	</form>

in Apache virtualhost:

	AddHandler cgi-script .cgi
	<Location "/cgi-bin/send-feedback.cgi">
		Options +ExecCGI
	</Location>

test from commandline:

	send-feedback.cgi message=test name=jozef subject=subj email=devnull@ba.pm.org
	send-feedback.cgi message=test name=jozef subject=subj email=devnull@ba.pm.org donotfillin=merobot

=head1 DESCRIPTION

=cut


use strict;
use warnings;

use CGI;
use MIME::Lite;
use Email::Address;

my $EMAIL_TO        = 'fb@ba.pm.org';
my $REDIRECT_OK     = '/cgi/email-ok.html';
my $REDIRECT_FAILED = '/cgi/email-fail.html';

my $EMAIL_ADDRESS_RE = $Email::Address::mailbox;

exit main();

sub main {
	my $q = CGI->new();
	
	# default redirection is to _FAILED
	my $REDIRECT = $REDIRECT_FAILED;
	
	# get parameters
	my $name        = $q->param('name')    || '';
	my $from        = $q->param('email')   || 'devnull@ba.pm.org';
	my $subject     = $q->param('subject') || '';
	my $message     = $q->param('message');
	my $donotfillin = $q->param('donotfillin');
	
	# if it was a robot that filled in the form, redirect to fail
	if ($donotfillin) {
		print $q->redirect(
			-uri    => 'http://'.$q->virtual_host.($q->server_port == 80 ? q{} : ':'.$q->server_port).$REDIRECT_FAILED,
			-status => 302
		);
		
		return 0;
	}
	
	$from = "$name <$from>"
		if ($name);

	# input check
	my $input_ok = 1;
	$input_ok = 0
		if ($from =~ m/\r|\n/m);
	$input_ok = 0
		if ($subject =~ m/\r|\n/m);
	$input_ok = 0
		if ($from !~ m/^$EMAIL_ADDRESS_RE$/xms);
	
	# only message paramter is mandatory
	if ($message and $input_ok) {
		# create message
		my $msg = MIME::Lite->new(
			From     => $from,
			To       => $EMAIL_TO,
			Subject  => $subject,
			Type     => 'text/plain; charset=UTF-8',
			Encoding => '8bit',
			Data     => $message,
		);
		
		# send email and redirect to _OK if sucessfull
		$REDIRECT = $REDIRECT_OK
			if eval { $msg->send('smtp', 'localhost'); };
	}
	
	# redirect
	print $q->redirect(
		-uri    => 'http://'.$q->virtual_host.($q->server_port == 80 ? q{} : ':'.$q->server_port).$REDIRECT,
		-status => 302
	);
    
    return 0;
}


__END__

=head1 AUTHOR

Jozef Kutej

=cut
