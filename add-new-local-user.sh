#!/bin/bash

#Allows user with super root priveleges to add new user
#Password is generated randomly for the username and comments provided in the command line as arguments
#Displays help like in man bash if no arguments are provided

if [[ "${UID}" -ne 0 ]]
then
	echo "Please sign in as the root user to perform this command!"
	exit 1
fi

if [[ "${#}" -eq 0 ]]
then
	echo "Command usage: ${0} USERNAME comments"
	exit 1
fi
USERNAME=${1}
shift
COMMENTS=${*}
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
$(useradd -c "${COMMENTS}" -m ${USERNAME})
echo ${PASSWORD} | passwd --stdin ${USERNAME}

if [[ "${?}" -ne 0 ]]
then
	echo "Internal error. Account not created :("
	exit 1
fi

passwd -e ${USERNAME}

echo "Account created successfully!"
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Host: ${HOSTNAME}"
exit 0


