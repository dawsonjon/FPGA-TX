#!/usr/bin/env python
from PIL import Image
import socket
import struct
import time

HOST = "192.168.1.1"
PORT = 23         
def test():

    #communicate
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
    for i in range(10):
        test_data = "".join([str(i) for j in range(1500)])
        s.sendall(test_data)
        time.sleep(1)
        print test_data
        print s.recv(1500)
    s.close()

test()
