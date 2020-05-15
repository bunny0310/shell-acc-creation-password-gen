#!/bin/bash

#usage function
usage() {
        echo "Usage: ${0} -[dra] [USERNAMES]" >&2
        echo "Disables account(s) of the usernames provided" >&2
        echo "-d delete account(s)" >&2
        echo "-r remove home directories of the accounts" >&2
        echo "-a Archive the account(s) data" >&2
        exit 1
}
#enforce root priveleges
if [[ ${UID} -ne 0 ]]
then
        echo "Please use sudo or sign in as root" >&2
        exit 1
fi

#use getopts to set appropriate variables; calls usage if an invalid option is provided
while getopts dra OPTION
do
        case ${OPTION} in
          d)
            DELETE=true
            ;;
          r)
            REMOVE_HOME=true
            ;;
          a)
            ARCHIVE=true
            ;;
          *)
            usage
            ;;
        esac
done

#uses ${OPTIND} to get rid of options for argument purposes
shift $((OPTIND -1 ))

#enforces user to provide atleast 1 argument
if [[ ${#} -lt 1 ]]
then
        usage
fi

#creates the archive directory if doesn't exist
if [[ ! -d 'archives' ]]
then
	$(mkdir archives)
fi

#loops over every user
for USER in ${@}
do
	#gets ID of the user
	ID=$(id -u ${USER} 2> /dev/null)
	
	#If the command fails, throws error and continues
	if [[ ${?} -ne 0 ]]
	then
		echo "User ${USER} not found or some internal error" >&2
		continue
	fi

	#If it's a system account, throws error and continues
	if [[ ${ID} -lt 1000 ]]
	then
		echo "${USER} has an id of less than 1000.Can't modify system users!" >&2
		continue
	fi	
	
	#Disables the user
	chage -E 0 ${USER} 2> /dev/null
	
	#If the command fails, throws error and continues else prints success message
	if [[ ${?} -ne 0 ]]
	then
		echo "Sorry, ${USER} cannot be disabled.">&2
	else
		echo "Congrations. User ${USER} has been disabled."
	fi

	#backs up home directory and removes home directory if specified and deletes the account
	
	#checks if backup option is selected
	if [[ ${ARCHIVE} == 'true' ]]
	then
		sudo tar -cvf archives/${USER}.tar  /home/${USER}
	fi

	 #If the command fails, throws error and continues else prints success message
        if [[ ${?} -ne 0 ]]
        then
                echo "Sorry, ${USER}'s home directory cannot be archived.">&2
        else
                echo "Congrations. User ${USER} has been backed up."
        fi

	#check if delete option is selected
	if [[ ${DELETE} == 'true' ]]
	then
		#check if remove home directory option is enabled or not
		if [[ ${REMOVE_HOME} == 'true' ]]
		then
			$(sudo userdel -r ${USER})
			 #If the command fails, throws error and continues else prints success message
        		if [[ ${?} -ne 0 ]]
        		then
                		echo "Sorry, ${USER} cannot be deleted /files remove error.">&2
        		else
                		echo "Congrations. User ${USER} has been deleted and files removed."
        		fi
		else
                        $(sudo userdel ${USER})
                         #If the command fails, throws error and continues else prints success message
                        if [[ ${?} -ne 0 ]]
                        then
                                echo "Sorry, ${USER} cannot be deleted..">&2
                        else
                                echo "Congrations. User ${USER} has been deleted."
                        fi
		fi
	fi
done
