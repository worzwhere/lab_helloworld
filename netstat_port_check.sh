# Created  by Worawut S. , 29 Mar 2018
# Using to check network port
# Running the script with admin user 

read -p "please insert a first port" po1
read -p "please insert second port" po2

while true; 
	do
	echo
	netstat -na |grep $po1
	netstat -na |grep $po2
	echo "------------------------------"
	sleep 5
done



