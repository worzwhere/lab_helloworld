import socket
from socket import socket

def mainRun();
	host="127.0.0.1"
	port=5000
	server=socket.socket()
	server.bind((host,port))
	server.listen(1)
	print("Waiting connection from Client : ")
	client,addr=server.accept()
	print("Connect from : " +str(addr))
	
	while True : 
		data=client.recv(1024).decode('utf-8')
		if not data :
			break
		print("Message from Client : "+data)
		data=str(data.upper())
		client.send(data.encode(utf-8))
	client.close()
	
	if __name__ =="__main__":
		mainRun()