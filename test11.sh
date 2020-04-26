#!/bin/bash

#This generates a random password
#This user can set the password length with -l and add a special character with -s
#Verbose mode can be enabled with -v

usage() {
	echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
	echo "Generate a random password"
	echo "-l specify the password length"
	echo "-s Append a special character to the password."
	echo "-v Increase verbosity."
	exit 1
}

vb() {
local MESSAGE="${@}"
if [[ "${VERBOSE}" = 'true' ]]
then
        echo ${MESSAGE}
fi
}

#set default password length
LENGTH=48

while getopts vl:s OPTION
do
	case ${OPTION} in
		v)
			VERBOSE='true'
			vb "Verbose mode on."
			;;
		l)
			LENGTH="${OPTARG}"
			;;
		s)
			USE_SPECIAL_CHARACTER='true'
			;;
		?)
			usage
			;;
	esac
done

vb "Generating a password"

PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

#Append a special character
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
	vb 'selecting a random special character'
	SPECIAL_CHARACTER=$(echo '!@#$%^&*()' | fold -w1 | shuf | head -c1)
	PASSWORD=${PASSWORD}${SPECIAL_CHARACTER}
fi

vb  "Done"
vb "Here's the password"
echo ${PASSWORD}
