#!/bin/bash

#
# Very basic Subversion (svn) graphical front end using only zenity.
#
# Copyright (C) 2008 Emmanuel Rodriguez
#
# This program is free software; you can redistribute it and/or modify it under
# the same terms as Perl itself, either Perl version 5.8.8 or, at your option,
# any later version of Perl 5 you may have available.
#

# The files to commit
files=$(\
  zenity --list --text="Files to commit" \
    --column=status --column=file \
  	--multiple --print-column=2 \
  	`svn status | grep -v '^[?] '` \
)

if [ $? -eq 0 ]; then 
	[ "$files" = "" ] && exit 1
else
	exit 2
fi	


# The commit message
message=$(\
  zenity --text-info --editable \
	  --title "Commit message for: $files" \
)
if [ $? -eq 0 ]; then 
	[ "$message" = "" ] && exit 3
else
	exit 4
fi	


# Confirm the commit
zenity --question --text="Commit changes to: $files?"
if [ $? -eq 0 ]; then 
	svn commit -m "$message" $files
else
	exit 3
fi	
