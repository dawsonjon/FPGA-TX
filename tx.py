import serial
import struct
from scipy.io.wavfile import read
import time

def check_hardware():
    for i in range(2):
        port.write("z")
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

port = serial.Serial('/dev/ttyUSB1', 230400, timeout=1)  # open serial port
check_hardware()
set_frequency(27.005e6, port)
set_amplitude(255)
transmit("test.wav", port, 'b')
#set_amplitude(0)
port.close()
