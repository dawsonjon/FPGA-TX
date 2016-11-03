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

def test(filename, port):
    messages = 500
    t0 = time.time()
    for i in range(messages):
        port.write('z'+chr(255)+"a"*255)
        response = port.readline()
        assert response[:255] == "a"*255
    t1 = time.time()
    seconds = t1-t0
    bytes_ = messages*255
    bits_ = bytes_*8
    print bytes_, "bytes returned with no errors"
    print "k bytes per second:", bytes_*1.0/(seconds*1000.0)
    print "k bit per second:", bits_*1.0/(seconds*1000.0)


port = serial.Serial('/dev/ttyUSB1', 230400, timeout=1)  # open serial port
check_hardware()
test("test.wav", port)
port.close()
