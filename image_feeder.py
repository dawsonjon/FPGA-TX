#!/usr/bin/env python
from PIL import Image
import socket
import struct

HOST = "192.168.1.1"
PORT = 80         
def test():

    #read test image
    im = Image.open("test.bmp")
    image_data = list(im.getdata())
    width, height = im.size
    image_data = "".join([struct.pack(">B", i) for i in image_data])
    
    #communicate
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((HOST, PORT))
    new_image = []
    for i in range(256):
        s.sendall(image_data[:256])
        image_data = image_data[256:]
        new_image.append(s.recv(256))
    s.close()

    words = []
    for line in new_image:
        while line:
            word = struct.unpack(">B", line[0])[0]
            line = line[1:]
            words.append(word)
    image_out = words


    #show the result
    new_im = Image.new(im.mode, (width, height))
    new_im.putdata(image_out)
    new_im.show() 

test()
