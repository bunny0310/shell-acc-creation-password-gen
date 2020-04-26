#!/bin/bash

#This script demonstrates I/O redirection

#Redirect STDOUT to a file.

FILE="/tmp/data"
head -n1 /etc/passwd >${FILE}

#Redirect STDIN to a program

read LINE < ${FILE}
echo "LINE contains: ${LINE}"

#Redirect STDOUT to a gile, overwriting the file
head -n3 /etc/passwd >${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

#Redirect STDOUT to a file, appending to the file
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo "${RANDOM} ${RANDOM}" >> ${FILE}
echo 
echo "Contents of ${FILE}:"
cat ${FILE}

#Redirect STDIN to a program using FD 0
read LINE 0< ${FILE}
echo 
echo "LINE contains: ${LINE}"

#Redirect STDOUT to a file using FD1
head -n3 /etc/passwd 1> ${FILE}
cat ${FILE}

#Redirect STDERR to a file using FD2
ERR_FILE="/tmp/data.err"
head -n3 /fakefile 2> ${ERR_FILE}

#Redirect both STDERR and STDOUT to a file
head -n3 /etc/passwd /fakefile >& ${ERR_FILE}
echo "Contents of the file are:"
cat ${ERR_FILE}

#Redirect STDERR and STDOUT through a pipe
head -n3 /etc/passwd /fakefile |& cat -n

#send output to STDERR
echo "This is STDERR!" >&2

#discarding STDOUT
echo "discarding STDOUT"
echo
head -n3 /etc/passwd /fakefile > /dev/null

#discarding STDERR
echo "discarding STDERR"
echo
head -n3 /etc/passwd /fakefile 2> /dev/null

#discarding STDOUT and STDERR both
echo "discarding STDOUT and STDERR both"
echo
head -n3 /etc/passwd /fakefile >& /dev/null
