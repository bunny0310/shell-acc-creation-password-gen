#!/bin/bash

#This script shows the open network ports on the system
#Only TCP v4 ports using -4 as an argument

#check if the supplied argument is 4 or 6
if [[ "${1}" != "-4"  ]]
then
	echo "Please supply the right version"
	exit 1
fi

netstat -nutl ${1} |grep ':' | awk '{print $4}'|awk -F ':' '{print $2}'
