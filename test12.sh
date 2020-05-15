#!/bin/bash

#This script deletes a user

#Runs as root

if [[ ${UID} -ne 0 ]]
then
	echo "Please run with sudo or as root." >&2
	exit 1
fi

#Assume the first argument is the user to delete
USER="${1}"

#Delete the user
userdel ${USER}

#Make sure that the user got deleted
if [[ "${?}" -ne 0 ]]
then
	echo "Bad news. " >&2
	exit 1
fi

#Tell user
echo "The account ${USER} was deleted."
exit 0
