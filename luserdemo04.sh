#!/bin/bash

#the script creates an account on the local system
#you will be pormpted for the account name and password

#Ask for the user name.
read -p "Enter the username to create: " USER_NAME

#Ask for the real name.
read -p "Enter the name of the person: " NAME

#Ask for the password
read -p "Enter the password: " PASSWORD

#Create the user
useradd -c "${NAME}" -m ${USER_NAME}
#Set the password for the user
 echo ${PASSWORD}| passwd --stdin ${USER_NAME}
	
#Force that user to change their password on first login
passwd -e ${USER_NAME}

#some random comment

