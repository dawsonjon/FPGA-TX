#!/usr/bin/env python

import serial
import struct
import numpy as np
from numpy import array, zeros, ones, around, unwrap, log10, angle
from scipy.signal import lfilter, freqz, remez
import matplotlib.pyplot as plt
import time
import sys

clock_frequency = 100.0e6
frequency_step_size = 800.0e6/(2.0**32.0)
fm_bits = 16
preemphasis_time_constant = 50e-6
hilbert_taps = 81
hilbert_width = 0.1

def generate_hilbert_filter(taps, width):
    return remez(taps, [width, 0.5-width], [1.0], type='hilbert')

def preemphasis(fs, tau):
    f1 = 1.0/tau
    f2 = 1.0e6
    b = array([(f1+2*fs)/(f2+2*fs), (f1-2*fs)/(f2+2*fs)])
    a = array([1, (f2-2*fs)/(f2+2*fs)])
    w, h = freqz(b*f2/f1, a)
    gain = max(abs(h))
    return gain, b, a

def error(message):
    print message
    sys.exit(1)

def check_hardware():
    for i in range(2):
        port.write("}")
        if port.readline() == ">\n":
            return
    error("Could not communicate with FPGA hardware")

def check_response(port, msg):
    response = port.readline()
    port.flushInput()
    if not response:
        error("No response from FPGA\n"+msg)
    if not response or response[0] != ">":
        error("Incorrect response from FPGA\n"+msg)

def set_frequency(frequency, port):
    frequency_steps = (frequency/frequency_step_size)
    port.write('f'+str(int(round(frequency_steps)))+'\n')
    port.flush()
    steps = port.readline().strip()
    print "frequency steps", steps
    check_response(port, "error setting frequency")

def set_fm_deviation(deviation, port):
    fm_resolution_hz = deviation/(2.0**fm_bits)
    fm_resolution_steps = fm_resolution_hz/frequency_step_size
    fm_resolution_256 = fm_resolution_steps * 256.0
    port.write('d'+str(int(round(fm_resolution_256)))+'\n')
    port.flush()
    multiplier = port.readline().strip()
    print "deviation_multiplier", multiplier
    check_response(port, "error setting fm deviation")

def set_sample_rate(sample_rate, port):
    sample_rate_clocks = clock_frequency/sample_rate
    port.write('s'+str(int(round(sample_rate_clocks)))+'\n')
    port.flush()
    sample_rate_clocks = port.readline().strip()
    print "sample_rate_clocks", sample_rate_clocks
    check_response(port, "error setting sample_rate")

def set_control_register(control, port):
    port.write('c'+str(int(control))+'\n')
    port.flush()
    control = port.readline().strip()
    print "control register", control
    check_response(port, "error setting control register")

def modulate_am(data):
    """convert to 7 bit, add dc bias, duplicate in i and q channel"""
    i = data/512+192
    q = data/512+192
    return (i+q*256)

def modulate_wbfm(data, gain, b, a):
    #data = data/32768.0
    #data = lfilter(b, a, data)*gain
    #print b, a, min(data), max(data)
    #data = around(data*32768).astype(int)
    return data+32768;

def modulate_ssb(data, kernel, taps, lsb=False):
    data = data/(2.0**15)
    G = taps/2
    i = np.concatenate([np.zeros(G), data[:-G]])
    q = lfilter(kernel, 1, data)
    if lsb:
        q = -q
    i = np.clip(i, -1, 1)
    q = np.clip(q, -1, 1)
    i = np.around(i*((2.0**7)-1))+128
    q = np.around(q*((2.0**7)-1))+128
    data = i*256.0+q
    return data

def modulate_fm(data):
    return data+32768;

def transmit(port, mode, sample_rate):
    if mode == "FM":
        #set sample rate
        set_sample_rate(sample_rate, port)
        #set maximum i and maximum q
        set_fm_deviation(5000, port)
        port.write("b"+chr(1)+chr(0)+chr(0))
        port.readline()
    elif mode == "WBFM":
        #set sample rate
        set_sample_rate(sample_rate, port)
        #set maximum i and maximum q
        set_fm_deviation(150000, port)
        port.write("b"+chr(1)+chr(0)+chr(0))
        port.readline()
        #calculate filter coefficients for preemphasis
        gain, b, a = preemphasis(sample_rate, preemphasis_time_constant)
    elif mode == "USB":
        #calculate filter coefficients for hilbert transform
        hilbert_kernel = generate_hilbert_filter(hilbert_taps, hilbert_width)
    elif mode == "LSB":
        #calculate filter coefficients for hilbert transform
        hilbert_kernel = generate_hilbert_filter(hilbert_taps, hilbert_width)

    while 1:
        #read 255 bytes into buffer
        data = sys.stdin.read(510)
        done = len(data) < 510
        length = len(data)/2
        data = struct.unpack("<"+("h"*length), data)
        data = array(data)

        #Apply any additional modulation
        #for formatting needed for a particular mode
        if mode == "AM":
            data = modulate_am(data)
            cmd = "b"
        elif mode == "FM":
            data = modulate_fm(data)
            cmd = "a"
        elif mode == "WBFM":
            data = modulate_wbfm(data, gain, b, a)
            cmd = "a"
        elif mode == "USB":
            data = modulate_ssb(data, hilbert_kernel, hilbert_taps)
            cmd = "b"
        elif mode == "LSB":
            data = modulate_ssb(data, hilbert_kernel, hilbert_taps, True)
            cmd = "b"

        #send frame to FPGA
        length = len(data)
        frame = struct.pack("<" + "H"*length, *data)
        port.write(cmd+chr(length)+frame)

        #Check response
        response = port.readline()
        if response != ">\n":
            error("incorrect response received"+response)
        if done:
            #switch off
            if mode == "USB" or mode == "LSB":
                port.write("b"+chr(1)+chr(128)+chr(128))
                port.readline()
            return

if len(sys.argv) <= 1 or "-h" in sys.argv or "--help" in sys.argv:
    print "\n".join([i.lstrip() for i in """Usage
    =====

    tx.py -f=<frequency> -m=<mode>"

    Accepts data from stdin in mono raw 16-bit pcm format
    Sampling rate should be 12kS/s

    options
    -------

    -f=<frequency>

    Specify transmit frequency in Hz

    -m=<mode>

    Mode may be AM or FM

    -d=<device>

    specify USB/serial device of transmitter. default is /dev/ttyUSB1
    
    
    e.g. sox test.wav -t raw -b 16 -r 12k - | ./tx.py -f=100e6 -m=fm
    """.splitlines()])
    sys.exit(0)
else:
    frequency = None
    mode = None
    device = "/dev/ttyUSB1"
    sample_rate=12000

    for arg in sys.argv[1:]:
        if arg.startswith("-f="):
            frequency = int(round(float(arg[3:])))
        elif arg.startswith("-m="):
            mode = arg[3:].upper()
        elif arg.startswith("-d="):
            device = arg[3:]
        elif arg.startswith("-r="):
            sample_rate = int(round(float(arg[3:])))

    if frequency is None:
        print "frequency must be specified"
        exit(0)

    if mode is None:
        print "mode must be specified"
        exit(0)


    port = serial.Serial(device, 12000000, timeout=1)  # open serial port
    check_hardware()
    set_frequency(frequency, port)
    set_control_register(1, port)
    transmit(port, mode, sample_rate)
    port.readline()
    port.close()
