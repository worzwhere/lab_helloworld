#!/bin/bash

echo "Which one that you want to take a look ?"
echo "[1] Disk space"
echo "[2] Disk part"
echo "[3] Other cmd"
read -n1 -p "Please select number [1 - 3] : " num

case "$num" in
        1)
			echo
			df -h
            ;;
         
        2)
           pwd
            ;;
         
        3)
			echo
			read -p " Insert the cmd : " cmd
			$cmd
			./select.sh
            ;;
			
		![1-3])
			
esac

echo 
echo "Completed"