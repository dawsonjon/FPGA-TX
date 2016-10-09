import socket
import fcntl
from PIL import Image
from scipy.io.wavfile import read
import random
import struct
import array
import time
import os
import sys

s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)

def all_interfaces():
    max_possible = 128  # arbitrary. raise if needed.
    bytes = max_possible * 32
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    names = array.array('B', '\0' * bytes)
    outbytes = struct.unpack('iL', fcntl.ioctl(
        s.fileno(),
        0x8912,  # SIOCGIFCONF
        struct.pack('iL', bytes, names.buffer_info()[0])
    ))[0]
    namestr = names.tostring()
    lst = []
    for i in range(0, outbytes, 40):
        name = namestr[i:i+16].split('\0', 1)[0]
        ip   = namestr[i+20:i+24]
        lst.append((name, ip))
    return lst


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

def send_audio(filename):

    #find out all network interfaces
    while 1:
        print "select network adaptor:"
        ifs = all_interfaces()
        for number, network_interface in enumerate(ifs):
            print number, network_interface[0]
        response = int(raw_input())
        if int(response) < len(ifs):
            break
    network_adaptor = ifs[int(response)][0]

    print "connecting to", network_adaptor,
    s.bind((network_adaptor, 3))
    print "...[OK]"

    #read test image
    print "reading audio file",
    path = os.path.split(os.path.abspath(__file__))[0]
    filename = os.path.join(path, filename)
    sample_rate, data = read(filename)
    print "sample rate:", sample_rate,
    data = data/256
    data = data+128
    print "length (samples)", len(data), data,
    print "...[OK]"
    
    #communicate
    print "sending audio file",
    while len(data) >= 256:
        frame = struct.pack(">" + "h"*256, *data[:256])
        data = data[256:]
        send(frame)
        get()
    print "...[OK]"

if __name__ == "__main__":
    send_audio(sys.argv[1])
