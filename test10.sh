#!/bin/bash

#a const variable
readonly VERBOSE='true'
readonly INPUT_FILE=${1}

#This function sends a message to syslog and to STDOUT if VERBOSE is true
log(){
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t test10.sh "${MESSAGE}"
}

#This function creates a backup of the file.
backup_file(){
	local FILE="${1}"
	
	#make sure that the file exists
	if [[ -f "${FILE}" ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
		log "BACKING UP ${FILE} to ${BACKUP_FILE}."
		cp -p ${FILE} ${BACKUP_FILE}
	else
		log "Error. File ${FILE} doesn't exit"
		return 1
	fi
		
}


backup_file ${INPUT_FILE}

if [[ ${?} -eq 0 ]]
then
	log 'FILE BACKUP SUCCEEDED!'
else
	log 'FILE BACKUP FAILED!'
	exit 1
fi

