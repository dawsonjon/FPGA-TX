from socket import *
from PIL import Image
import random
import struct
import time

#User settings start here
#########################

#network_adaptor = "eth0"
network_adaptor = "eth1"

#User settings end here
#######################



def send(payload):
    """Send data to demo card via raw ethernet frame"""
    length = struct.pack(">H", len(payload))
    s.send("\x00\x01\x02\x03\x04\x05\x00\xe0\x53\x15\xba\xda" + length + payload)

def get():
    """Get data from demo card via raw ethernet frame"""
    while 1:
        packet = s.recv(2048)
        if packet[6:12] == "\x00\x01\x02\x03\x04\x05":
            return packet[14:]

def print_packet(packet):
    """Print packet in a human readble form."""
    for j in range((len(packet)/10) + 1):
        print "%08x :"%(j*10),
        for i in range(10):
            if j*10+i == len(packet):
                print ""
                return
            print "%02x"%ord(packet[j*10+i]),
        print ""

def test():
    global s
    print "connecting to", network_adaptor,
    s.bind((network_adaptor, 3))
    print "...[OK]"

    #read test image
    im = Image.open("test.bmp")
    image_data = list(im.getdata())
    width, height = im.size
    
    #communicate
    t0 = time.clock()
    new_image = []
    for i in range(256):
        row = struct.pack(">" + "h"*256, *image_data[:256])
        image_data = image_data[256:]
        send(row)
        new_row = struct.unpack(">" + "h"*256, get())
        new_image.extend(new_row)
    t1 = time.clock()
    bytes_sent = width * height * 2
    time_taken = t1-t0
    print bytes_sent, "bytes transferred in", time_taken, "seconds"
    print ((bytes_sent/time_taken) * 8)/1000000, "Mbits/s"

    #show the result
    new_im = Image.new(im.mode, (width, height))
    new_im.putdata(new_image)
    new_im.show() 
    new_im.save("out.bmp") 

def run():
    print "1. edit demo/examples/raw_ethernet/host.py to correct Ethernet adaptor (default eth1)."
    print "2. Connect Ethernet cable from host to development card"
    print "3. Press enter when ready..."
    _ = raw_input()
    global s
    s = socket(AF_PACKET, SOCK_RAW)
    test()


