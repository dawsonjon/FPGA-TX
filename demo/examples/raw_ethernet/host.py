from socket import *
import random
import struct
import time

#User settings start here
#########################

#network_adaptor = "eth0"
network_adaptor = "eth1"

#User settings end here
#######################

s = socket(AF_PACKET, SOCK_RAW)
s.bind((network_adaptor, 3))


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
    byte_sent = 0
    start = time.clock()
    for i in range(10000):
        print "sending random packet:", i,
        packet_to_send = "".join([chr(random.randint(0, 255)) for i in xrange(random.randint(46, 1500))])
        send(packet_to_send)
        packet_got = get()
        print "bytes_sent", hex(len(packet_to_send) + 12), "bytes received",  hex(len(packet_got) + 12)
        byte_sent += len(packet_to_send)
        if packet_to_send != packet_got:
            print "failure"
            print "sent:"
            print_packet(packet_to_send)
            print "got:"
            print_packet(packet_got)
            exit(0)
    end = time.clock()
    print "pass"
    print "total bytes sent and received:", byte_sent, "in:", end-start, "seconds"
    print "average speed:", ((byte_sent/end-start) * 8.0)/1000000.0, "Mbit/s"

def run():
    print "1. edit demo/examples/raw_ethernet/host.py to correct Ethernet adaptor (default eth1)."
    print "2. Connect Ethernet cable from host to development card"
    print "3. Press enter when ready..."
    _ = raw_input()
    test()


