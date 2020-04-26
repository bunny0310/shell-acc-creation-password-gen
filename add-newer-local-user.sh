#check for root priveleges
if [[ "${UID}" -ne 0 ]]
then
	echo "Please run this file with root priveleges" >&2
	exit 1
fi

#Provides a usage statement
if [[ "${#}" -eq 0 ]]
then
	echo "Usage- ${0} Username Comments" >&2
	exit 1
fi

#Adds a new user
USERNAME=${1}
shift
COMMENTS=${*}
PASSWORD=$(date +%s%N${RANDOM}${USERNAME} | sha256sum | head -c48)
$(useradd -m ${USERNAME} -c "${COMMENTS}") >& /dev/null
echo ${PASSWORD} | passwd --stdin ${USERNAME} >& /dev/null

#check if the commands executed successfully or not
if [[ "${?}" -ne 0 ]]
then
	echo "Internal error. Sorry." >&2
	exit 1
fi

#Displays the result
echo "Username: ${USERNAME}"
echo
echo "Password: ${PASSWORD}"
echo 
echo "Host: ${HOSTNAME}"
