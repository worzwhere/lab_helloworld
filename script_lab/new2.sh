#!/bin/bash

echo
echo "Select the command"
echo
echo "[1] Check Disk Space"
echo "[2] Delete log files"
echo "[3] Login With Other"
echo
echo "[0] Exit"
echo
read -p "Please select number [1 - 3] : " num

case "$num" in

		0)
            echo "Exit the batch"
            ;;
        1)
            df -h
            ;;
         
        2)
			ls -lart
			read -p "type \"YES\" to do a delete job : " yes
			echo 'You replied with' \"$yes\"
			touch test_del.txt

			case "$yes" in
	
				YES)
					ls -lart *.txt
					rm -f *.txt
					ls -lart
					echo
					echo "All log \".txt\" have been deleted" 
					;;
	
				*)
					echo
					echo "The Job has been cancel"
					;;
			esac
            ;;
         
        3)
			read -p " Login With Other user, please insert user name : " user
			Message="Login With "$user
			su - $user
            ;;
			
		*)
			echo "Input a wrong number!!"
			./new2.sh
			;;
			
esac
