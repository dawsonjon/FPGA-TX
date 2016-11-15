import serial
import struct
from scipy.io.wavfile import read
import time
import sys

def check_hardware():
    for i in range(2):
        port.write(">")
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
        test_code = "abcdefghij"*20
        port.write('z'+chr(len(test_code))+test_code)
        response = port.readline()
        if response[:len(test_code)] != test_code:
            print response
            exit(0)
    t1 = time.time()
    seconds = t1-t0
    bytes_ = messages*255
    bits_ = bytes_*8
    print bytes_, "bytes returned with no errors"
    print "k bytes per second:", bytes_*1.0/(seconds*1000.0)
    print "k bit per second:", bits_*1.0/(seconds*1000.0)


port = serial.Serial('/dev/ttyUSB1', 12000000, timeout=1)  # open serial port
check_hardware()
for i in range(100):
    test("test.wav", port)
port.close()
