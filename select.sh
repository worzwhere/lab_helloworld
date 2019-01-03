#!/bin/bash

echo "Select the user login"
echo "[1] Login With Root"
echo "[2] Login With Oracle"
echo "[3] Login With Other"
read -n1 -p "Please select number [1 - 3] : " num

case "$num" in
        1)
            Message="Login With Root"
			su - root
            ;;
         
        2)
           Message="Login With Oracle"
		   su - oracle
            ;;
         
        3)
			read -p " Login With Other user, please insert user name : " user
			Message="Login With "$user
			su - $user
            ;;
			
esac

echo "You are" $Message
exit 0