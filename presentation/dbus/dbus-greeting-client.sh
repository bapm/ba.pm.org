#!/bin/sh

if [ "$#" -lt 1 ]; then
	echo "Usage: name"
	exit 1
fi

name="$1"

exec dbus-send --print-reply --session \
  --dest=org.example.Greeting \
	/org/example/Greeting \
	org.example.Greeting.Hello \
	string:"$name"
