#!/bin/bash

#TODO usage print , help, argument opt for word or substring AprLifecycleListener
if [ -z $1  ]
then
	printf "Usage: ./parse.sh <file to be parsed> <delimiter string> \n\nOutput will be the all the lines of the file that come after the line with the delimiter string.\n"
	exit
fi

input=$1

last_restart="*AprLifecycleListener*"

if [$2 == ""]
then
	echo "Will create file containing last restart logs."
	trimDelimiter=$last_restart
else
	trimDelimiter=$2
fi

found=0

echo "searching logs after $trimDelimiter"

while IFS= read -r var
do
	if [[ $var == $trimDelimiter || $found == 1 ]]
	then
		found=1
		echo "$var" >> trimmedLogs_$trimDelimiter.txt
	fi
done < "$input"

