function net_num () { while [[ 1=1 ]]; do
netstat -an |grep $PORT_NUM
echo
sleep 5
done
}

read -p "Please input the port number : " PORT_NUM
net_num $PORT_NUM