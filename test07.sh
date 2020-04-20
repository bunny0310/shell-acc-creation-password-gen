#!/bin/bash

#Demonstrate the use of shift and while loops

#Display the first 3 parameters
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"

#loop through all the positional parameters
while [[ "${#}" -gt 0 ]]
do
	echo "Number of parameters is ${#}"
	echo "Parameter 1: ${1}"
	echo 
	shift
done
