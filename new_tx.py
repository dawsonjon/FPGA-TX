#!/usr/bin/env python

import serial
import struct
from scipy.io.wavfile import read
import time
import sys

def check_hardware():
    for i in range(2):
        port.write("}")
        if port.readline() == ">\n":
            return
    assert False

def check_response(port, error):
    response = port.readline()
    port.flushInput()
    if not response:
        print "read timed out"
        print error
        assert False
    if not response or response[0] != ">":
        print error
        for i in response:
            print ord(i)
        assert False

def set_frequency(frequency, port):
    port.write('f'+str(int(round(frequency)))+'\n')
    port.flush()
    steps = port.readline().strip()
    print "frequency steps", steps
    check_response(port, "error setting frequency")

def set_amplitude(amplitude):
    port.write("a"+chr(1)+chr(amplitude))
    port.readline()

def transmit(port, mode):
    while 1:
        #read 255 bytes into buffer
        data = sys.stdin.read(510*2)
        length = len(data)/2
        data = struct.unpack("<"*(length*"h"), data)
        #convert to 8 bit unsigned
        data = data/256
        data = data+128
        #send 255 bytes to FPGA
        frame = struct.pack(">" + "B"*length, *data)
        port.write(mode+chr(length)+frame)
        #Check response
        if port.readline() != ">\n":
            print "unexpected response"

#extract 
if len(sys.argv) <= 1 or "-h" in sys.argv or "--help" in sys.argv:
    print "Usage:"
    print "tx.py -f=<frequency> -m=<mode>"
    print""
    print "e.g. sox test.wav -t raw -b 16 -r 12k - | ./tx.py -f=100e6 -m=fm"
    sys.exit(0)
else:
    frequency = None
    mode = None
    device = "/dev/ttyUSB1"

    for arg in sys.argv[1:]:
        if arg.startswith("-f="):
            frequency = int(round(float(arg[3:])))
        elif arg.startswith("-m="):
            mode = arg[3:]

    if frequency is None:
        print "frequency must be specified"
        exit(0)

    if mode is None:
        print "mode must be specified"
        exit(0)

    port = serial.Serial('/dev/ttyUSB1', 3692308, timeout=1)  # open serial port
    print "ok"
    check_hardware()
    set_frequency(frequency, port)
    set_amplitude(255)
    port.write("b"+chr(1)+chr(128))
    port.readline()
    if mode == "am":
        transmit(port, 'a')
    elif mode == "fm":
        transmit(port, 'b')
    port.write("b"+chr(1)+chr(128))
    port.readline()
    set_amplitude(0)
    port.close()
