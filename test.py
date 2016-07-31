import socket
import time

my_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
my_socket.connect(("192.168.1.1", 80))

message = "12345678"
for i in range(20000):
    my_socket.sendall(message)
    data = my_socket.recv(8)
    print i, data
