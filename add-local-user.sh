#!/bin/bash
#check if root
if [[ "${UID}" -ne 0 ]]
then
	echo "You need to be root to make changes"
	exit 1
fi

#read details
read -p "Enter name: " NAME
read -p "Enter username: " USERNAME
read -p "Enter password: " PASSWORD


#create the account
$(useradd -c "${NAME}" -m ${USERNAME})
ISACSET=$?
echo ${PASSWORD} | passwd --stdin ${USERNAME}
ISPWDSET=$?
if [[ "${ISACSET}" -ne 0 ]]
then
        echo "Error in account creation"
        exit 1
fi
if [[ "${ISPWDSET}" -ne 0 ]]
then
        echo "Error in password setting"
        exit 1
fi
passwd -e ${USERNAME}
echo "Account created successfully!"
echo "Username: ${USERNAME}"
echo "Password: ${PASSWORD}"
HOSTNAME=$(id -un)
echo "Host: ${HOSTNAME}"
exit 0
