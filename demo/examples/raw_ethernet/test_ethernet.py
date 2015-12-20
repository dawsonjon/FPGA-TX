import random
import time
from raw_ethernet import *

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

def test_ethernet():
    user_select_adaptor()
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

if __name__ == "__main__":
    test_ethernet()

