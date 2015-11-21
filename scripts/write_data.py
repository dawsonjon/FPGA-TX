#!/usr/bin/env python
from PIL import Image
import socket
import struct

HOST = "192.168.1.1"
PORT = 23         

#communicate
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))
for i in range(3000):
    s.sendall(str(i))
s.close()
