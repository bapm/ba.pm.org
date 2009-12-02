#!/bin/bash

case "$1" in
	start)
		IN_DEBUG_MODE=1 examples/ViennaPM1/script/viennapm1_server.pl &
		examples/ViennaPM1/script/viennapm1_server.pl -p 3001 &
	;;
	
	stop)
		killall viennapm1_server.pl
	;;
	
	restart)
		$0 start
		$0 stop
	;;
	
	*)
		echo "usage: $0 start|stop|restart"
	;;
esac

