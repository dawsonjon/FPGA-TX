#!/usr/bin/env python

import serial
import struct
from scipy.io.wavfile import read
import time
import sys


sample_rate, data = read("test.wav")
print list(data)[:10]

inf = open("test.raw").read(20)
print struct.unpack("<hhhhhhhhhh", inf)
print inf
