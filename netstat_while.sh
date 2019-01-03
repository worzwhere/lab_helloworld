while true; 
	do
	echo
	netstat -na |grep 137 && netstat -na |grep 139
	echo "------------------------------"
	sleep 5
done