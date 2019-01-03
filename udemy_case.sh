#!/bin/bash

# pratice case statment

# function list

function hello { 

cat << "EOF"
 _          _ _               _           _
| |__   ___| | |   ___     __| |_   _  __| | ___
| '_ \ / _ \ | |  / _ \   / _` | | | |/ _` |/ _ \
| | | |  __/ | | | (_) | | (_| | |_| | (_| |  __/
|_| |_|\___|_|_|  \___/   \__,_|\__,_|\__,_|\___|

*********************************************************************
Here is our new corporate approved login banner.  Bad guys stay away.
I'm serious.  We're watching everything you do, so don't even try it.
*********************************************************************

EOF
}

function stop { 

	for load in $(seq 1 100); do
    echo -ne " Stoping at ${load} %  ...\r"
    sleep 0.2
done
echo
echo "Stopped ..."
}

# case 

echo "Wordlist case"
echo "1. Starting"
echo "2. Stoping"
echo "3. Status"
# read -n1 -p "Please select number: " num ( -n1 for insert only a string)
read -p "Please select number: " num
echo

case "${num}" in
	1 )
	hello
	;;
	2 )
	stop
	;;
	3 )
	echo "Status"
	;;
	* )
	echo "Wrong number!!!"
	./udemy_case.sh
	;;
esac