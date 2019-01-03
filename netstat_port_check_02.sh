function net_num () { while [[ 1=1 ]]; do
netstat -an |grep 49521
echo
sleep 5
done
}

read -p "Please input the port number : " PORT_NUM
net_num 49521
