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

def transmit(filename, port, mode):
    sample_rate, data = read(filename)
    print data
    data = data/256
    data = data+128
    print "reading file sample rate:", sample_rate,
    print "length (samples)", len(data), data,
    print "...[OK]"
    print "sending audio file ...",
    count = 0
    while len(data):
        count += 1
        if len(data) > 255:
            length = 255
        else:
            length = len(data)
        frame = struct.pack(">" + "B"*length, *data[:length])
        data = data[length:]
        port.write(mode+chr(length)+frame)
        if port.readline() != ">\n":
            print "blah"
    print "[OK]"
    print count

#extract 
if len(sys.argv) <= 1 or "-h" in sys.argv or "--help" in sys.argv:
    print "Usage:"
    print "tx.py -f=<frequency> -m=<mode>"
    print "e.g. sox test.wav -t raw -b 16 -r 12k - | ./tx.py -f=100e6 -m=fm"
    sys.exit(0)
else:
    for arg in sys.argv[1:]:
        if arg.startswith("-f="):
            frequency = int(round(float(arg[3:])))
        elif arg.startswith("-m="):
            mode = arg[3:]


    port = serial.Serial('/dev/ttyUSB1', 230400, timeout=1)  # open serial port
    check_hardware()
    set_frequency(frequency, port)
    set_amplitude(255)
    port.write("b"+chr(1)+chr(128))
    port.readline()
    if mode == "am":
        transmit("test.wav", port, 'a')
    elif mode == "fm":
        transmit("test.wav", port, 'b')
    port.write("b"+chr(1)+chr(128))
    port.readline()
    set_amplitude(0)
    port.close()
