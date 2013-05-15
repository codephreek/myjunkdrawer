#!/usr/bin/env bash

if [ $# -ne 1 ]; then
	echo "Error: Not enough arguments" 1>&2
	echo "Supply a regular expression to match on: " 1>&2
	echo "$0 \"(internode|rtr|testClient)\"" 1>&2
	exit 1
fi

while true; do 
	MYVAR=`ps auxww | grep -E "$1" | grep -v grep | grep -v $0 | sort --key=11`; 
	echo "$MYVAR"; 
	CNT=`echo "$MYVAR" | wc -l`; 
	sleep 0.5; 
	while [ $CNT -ne 0 ]; do 
		echo -n "M"; ((CNT=CNT-1)); 
	done; 
done
