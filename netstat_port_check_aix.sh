# Created  by Worawut S. , 29 Mar 2018
# Using to check network port
# Running the script with admin user 

read po1?'please insert a first port number : '
read po2?'please insert second port number : '
read sl1?'please insert a responding (sec) : '

while true; 
	do
	echo
	netstat -na |grep $po1
	netstat -na |grep $po2
	echo "------------------------------"
	sleep $sl1
done