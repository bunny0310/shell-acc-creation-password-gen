#!/bin/bash

#Display the UID and username of the user executing the script

#Display id the user is the vagrant user or not

#Display the UID
echo "Your UID is ${UID}"

#Only display the message if the UID doesnot match 1000
UID_TO_TEST_FOR="1000"
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
	echo "Your UID doesn't match ${UID_TO_TEST_FOR} "
	exit 1	
fi

#Display the Username
USER_NAME=$(id -un)

#Test if the command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "The id command doesn't equal successfully"
	exit 1
fi
echo "Your username is ${USER_NAME}. "
#String test conditional
USER_NAME1="vagrant"
if [[ "${USER_NAME}" = "${USER_NAME1}" ]]
then
	echo "Your username matches ${USER_NAME1}"
fi

#Test for != of the string
