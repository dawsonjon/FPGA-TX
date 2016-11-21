#!/usr/bin/env python

import serial
import struct
import numpy as np
from numpy import array, zeros, ones, around, unwrap, log10, angle
from scipy.signal import lfilter, freqz, remez
from scipy import signal
import matplotlib.pyplot as plt
import time
import sys

clock_frequency = 100.0e6
frequency_step_size = 800.0e6/(2.0**32.0)
fm_bits = 16

def create_lowpass_filter(fs, cutoff):
    kernel = signal.firwin(50, cutoff, pass_zero=True, nyq=fs/2.0) 
    w, h = signal.freqz(kernel)
    gain = max(abs(h))
    return kernel, gain

def create_preemphasis_filter(fs, tc):
    #create pre-emphasis filter kernel
    f1 = 1.0/fs
    f2 = 1.0e6
    b = array([(f1+2*fs)/(f2+2*fs), (f1-2*fs)/(f2+2*fs)])
    a = array([1, (f2-2*fs)/(f2+2*fs)])

    #calculate frequency response
    w, h = signal.freqz(b, a)
    f = w/(2*np.pi)#convert to normalised frequency

    #gain increases with frequency, so
    #find gain at maximum audio frequency
    gain = abs(h[int(round((2*15e3)/fs))])

    return b, a, gain

class Modulator:
    def __init__(self, 
            frequency=30.0e6, 
            sample_rate=12000, 
            fm_deviation=5000, 
            cutoff=5000, 
            preemphasis_time_constant=50.0e-6,
            lsb=False):
        self.frequency = frequency
        self.sample_rate = sample_rate
        self.fm_deviation = fm_deviation
        self.preemphasis_time_constant = preemphasis_time_constant
        self.lsb = lsb
        self.lpf_kernel, self.lpf_gain = create_lowpass_filter(
                sample_rate, 
                cutoff
        )

    def setup_transmitter(self, transmitter):
        transmitter.set_frequency(self.frequency)
        transmitter.set_sample_rate(self.sample_rate)
        transmitter.set_fm_deviation(self.fm_deviation)
        transmitter.set_control_register(1)

class SSBModulator(Modulator):
    def __init__(self, *args, **kwargs):
        Modulator.__init__(self, *args, **kwargs)
        self.taps = 81
        self.kernel = remez(
                self.taps,
                [0.1, 0.4], 
                [1.0], 
                type='hilbert'
        )

    def setup_transmitter(self, transmitter):
        Modulator.setup_transmitter(self, transmitter)
        transmitter.cmd = 'b'

    def modulate(self, data):

        # SSB Modulator
        # =============
        #
        #                               
        #         +-----+  +----------+     +---------+
        #  audio -> lpf >--> resample >--+--> delay   >------------> I
        #         +-----+  | (12 kHz) |  |  +---------+
        #                  +----------+  |
        #                                |  +---------+  +------+
        #                                +--> Hilbert >--> lsb? >--> Q
        #                                   +---------+  | *-1  |
        #                                                +------+

        #convert to floating point
        data = data/32768.0

        #low pass filter
        data = lfilter(self.lpf_kernel, 1, data)/self.lpf_gain

        #resample to 12K
        fs = 12.0e3
        resample_factor = fs/self.sample_rate
        new_samples = int(round(len(data) * resample_factor))
        data = signal.resample(data, new_samples)

        #pass through hilbert filter
        G = self.taps/2
        i = np.concatenate([np.zeros(G), data[:-G]])
        q = lfilter(self.kernel, 1, data)
        i = i[:len(q)]

        if self.lsb:
            q = -q
        
        self.fft = 20.0*np.log10(abs(np.fft.fftshift(np.fft.fft(i-1.0j*q))))
        self.nyq = self.sample_rate/2000.0

        #convert to 8-bit
        i = np.clip(i, -1, 1)
        q = np.clip(q, -1, 1)
        i = np.around(i*((2.0**7)-1))+128
        q = np.around(q*((2.0**7)-1))+128
        data = (i*256.0)+q
        return data

class WBFMModulator(Modulator):
    def __init__(self, *args, **kwargs):
        Modulator.__init__(self, *args, **kwargs)
        self.b, self.a, self.preemp_gain = create_preemphasis_filter(
                self.sample_rate, 
                self.preemphasis_time_constant
        )

    def setup_transmitter(self, transmitter):
        Modulator.setup_transmitter(self, transmitter)
        transmitter.set_iq(0, 0)
        transmitter.cmd = 'a'

    def modulate(self, data):

        # Wideband FM Modulator
        # =====================
        #
        #        +-----+ +----------+
        # audio -> lpf >-> pre-emph >--> frequency
        #        +-----+ +----------+
        #
        

        #convert to floating point
        data = data/32768.0

        #low pass filter
        data = lfilter(self.lpf_kernel, 1, data)/self.lpf_gain

        #add preemphasis
        data = lfilter(self.b, self.a, data)/self.preemp_gain

        #fft plot
        self.fft = 20.0*np.log10(abs(np.fft.fftshift(np.fft.fft(data))))
        self.nyq = self.sample_rate/2000.0

        #convert to 16-bit pcm
        data = np.clip(data, -1, 1)
        data = around(data*32767).astype(int)
        return data+32768;

class StereoModulator(Modulator):
    def __init__(self, *args, **kwargs):
        Modulator.__init__(self, *args, **kwargs)
        self.b, self.a, self.preemp_gain = create_preemphasis_filter(
                self.sample_rate, 
                self.preemphasis_time_constant
        )
        #create pilot_tone and stereo sub carrier
        fsh = 152.0e3
        t = np.arange(0, 20e-3, 1/fsh)
        self.pilot = np.sin(2*np.pi*19.0e3*t)
        self.subcarrier = np.sin(2*np.pi*38.0e3*t)

    def setup_transmitter(self, transmitter):
        Modulator.setup_transmitter(self, transmitter)
        transmitter.set_iq(255, 255)
        transmitter.set_sample_rate(152e3)
        transmitter.cmd = 'a'

    def modulate(self, data):

        # Stereo FM Modulator
        # ===================
        #
        #        +-----+ +----------+      +---+         +-------+  +---+
        #  left -> lpf >-> pre-emph >---+--> + >---------> *0.45 >--> + >--> frequency
        #        +-----+ +----------+ +---->   |         +-------+  |   |
        #                             | |  +---+                    |   |
        #        +-----+ +----------+ | |  +---+  +---+  +-------+  |   |
        # right -> lpf >-> pre-emph >-+ +--> - >--> * >--> *0.45 >-->   |
        #        +-----+ +----------+ +---->   |  +-^-+  +-------+  |   |
        #                                  +---+    |               |   |
        #                                         ~38 kHz           |   |
        #                                                           |   |
        #                                                +-------+  |   |
        #                                         19 kHz-> *0.1  >-->   |
        #                                                +-------+  +---+

        #convert to floating point
        data = data/32768.0

        #split data into left and right channels
        left = data[::2]
        right = data[1::2]

        #lowpass filter
        left = lfilter(self.lpf_kernel, 1, left)/self.lpf_gain
        right = lfilter(self.lpf_kernel, 1, right)/self.lpf_gain

        #preemphasis
        left = lfilter(self.b, self.a, left)/self.preemp_gain
        right = lfilter(self.b, self.a, right)/self.preemp_gain

        #upsample data
        fsh = 152.0e3
        resample_factor = fsh/self.sample_rate
        new_samples = int(round(len(left) * resample_factor))
        left = signal.resample(left, new_samples)
        right = signal.resample(right, new_samples)

        #shift subcarrier and pilot to maintain phase across frames
        subcarrier = self.subcarrier[:new_samples]
        self.subcarrier = np.concatenate([self.subcarrier[new_samples:], 
            subcarrier])
        pilot = self.pilot[:new_samples]
        self.pilot = np.concatenate([self.pilot[new_samples:], pilot])

        left *= 0.05
        right *= 0.05
        data = (left + right) * 0.45
        data += (left - right) * subcarrier * 0.45
        data += pilot * 0.1

        #fft plot
        self.fft = 20.0*np.log10(abs(np.fft.fftshift(np.fft.fft(data))))
        self.nyq = 152.0e3/2000.0
        
        #convert to 16-bit pcm
        data = np.clip(data, -1, 1)
        data = around(data*32767).astype(int)

        return data+32768;

class FMModulator(Modulator):

    def setup_transmitter(self, transmitter):
        Modulator.setup_transmitter(self, transmitter)
        transmitter.set_iq(255, 255)
        transmitter.cmd = 'a'

    def modulate(self, data):

        # FM Modulator
        # ============
        #
        #         +-----+
        #  audio -> lpf >--> frequency
        #         +-----+ 
        #               

        #convert to floating point
        data = data/32768.0

        #low pass filter
        data = lfilter(self.lpf_kernel, 1, data)/self.lpf_gain

        #fft plot
        self.fft = 20.0*np.log10(abs(np.fft.fftshift(np.fft.fft(data))))
        self.nyq = self.sample_rate/2000.0

        #convert to 16-bit pcm
        data = np.clip(data, -1, 1)
        data = around(data*32767).astype(int)

        return data+32768;

class AMModulator(Modulator):

    def setup_transmitter(self, transmitter):

        Modulator.setup_transmitter(self, transmitter)
        transmitter.cmd = 'b'

    def modulate(self, data):

        # AM Modulator
        # ============
        #
        #                                                     +---> I
        #         +-----+  +----------+  +------+   +------+  |
        #  audio -> lpf >--> resample >--> *0.5 >---> +0.1 >--+
        #         +-----+  | (12 kHz) |  +------+   +------+  |
        #                  +----------+                       +---> Q
        #               

        #convert to floating point
        data = data/32768.0

        #low pass filter
        data = lfilter(self.lpf_kernel, 1, data)/self.lpf_gain

        #resample to 12K
        fs = 12.0e3
        resample_factor = fs/self.sample_rate
        new_samples = int(round(len(data) * resample_factor))
        data = signal.resample(data, new_samples)

        #amplitude modulate
        i = data*0.5+1.0
        q = data*0.5+1.0

        #fft plot
        self.fft = 20.0*np.log10(abs(np.fft.fftshift(np.fft.fft(i+1.0j*q))))
        self.nyq = self.sample_rate/2000.0

        #convert to 8-bit
        i = np.clip(i, -1, 1)
        q = np.clip(q, -1, 1)
        i = np.around(i*((2.0**7)-1))+128
        q = np.around(q*((2.0**7)-1))+128
        data = (i*256.0)+q
        return data

class TransmitterException(Exception):
    pass

def error(message):
    raise TransmitterException(message)

class Transmitter:

    def __init__(self, device, modulator):
        self.port = serial.Serial(device, 12000000, timeout=1)
        self.check_hardware()
        modulator.setup_transmitter(self)
        self.modulator = modulator
        self.stop = False

    def __del__(self):
        if hasattr(self, "port"):
            self.set_iq(127,127)
            self.port.close()

    def reset_hardware(self):
        self.port.flushInput()
        while 1:
            self.port.write("               >")
            response = self.port.readline()
            if response.endswith(">\n"):
                return

    def check_hardware(self):
        self.reset_hardware()
        self.port.write(">")
        response = self.port.readline()
        if response == ">\n":
            return
        error("Could not communicate with FPGA hardware, response: "+response)

    def check_response(self, msg):
        response = self.port.readline()
        self.port.flushInput()
        if not response:
            error("No response from FPGA\n"+msg)
        if not response or response[0] != ">":
            error("Incorrect response from FPGA\n"+msg)

    def set_frequency(self, frequency):
        frequency_steps = (frequency/frequency_step_size)
        self.port.write('f'+str(int(round(frequency_steps)))+'\n')
        self.port.flush()
        steps = self.port.readline().strip()
        print "frequency steps", steps
        self.check_response("error setting frequency")

    def set_fm_deviation(self, deviation):
        fm_resolution_hz = deviation/(2.0**fm_bits)
        fm_resolution_steps = fm_resolution_hz/frequency_step_size
        fm_resolution_256 = fm_resolution_steps * 256.0
        self.port.write('d'+str(int(round(fm_resolution_256)))+'\n')
        self.port.flush()
        multiplier = self.port.readline().strip()
        print "deviation_multiplier", multiplier
        self.check_response("error setting fm deviation")

    def set_sample_rate(self, sample_rate):
        sample_rate_clocks = clock_frequency/sample_rate
        print "setting sample rate", sample_rate
        self.port.write('s'+str(int(round(sample_rate_clocks)))+'\n')
        self.port.flush()
        sample_rate_clocks = self.port.readline().strip()
        print "sample_rate_clocks", sample_rate_clocks
        self.check_response("error setting sample_rate")

    def set_control_register(self, control):
        self.port.write('c'+str(int(control))+'\n')
        self.port.flush()
        control = self.port.readline().strip()
        print "control register", control
        self.check_response("error setting control register")

    def set_iq(self, i, q):
        self.port.write("b"+chr(1)+chr(0)+chr(i)+chr(q))
        self.port.readline()

    def transmit(self, in_file):
        first = True
        while 1:
            #tx has a 8kx8byte buffer
            #assuming 2bytes/sample, 2016 samples should ~quarter fill the
            #buffer in stereo ~3 times as many samples are generated

            t0 = time.time()
            data = in_file.read(3448)
            done = len(data) < 3448
            length = len(data)/2
            data = struct.unpack("<"+("h"*length), data)
            data = array(data)
            t1 = time.time()

            #modulate data into iq or frequency format
            data = self.modulator.modulate(data)
            t2 = time.time()

            #send frame to FPGA
            length = len(data)
            frame = "".join([">"]+[self.cmd+chr(int(i)&0xff)+chr(int(i)>>8) for i in data])
            t3 = time.time()

            #Check response
            response = self.port.readline()
            if response != ">\n" and not first:
                first = False
                if len(response) == 0:
                    print "no response received"
                    self.reset_hardware()
                    self.check_hardware()
                else:
                    print "Incorrect response"
                    print response
                    self.reset_hardware()

            t4 = time.time()
            self.port.write(frame)
            t5 = time.time()

            #print t1-t0, t2-t1, t3-t2, t4-t3, t4-t5, t5-t0

            if done or self.stop:
                #switch off
                self.set_iq(128, 128)
                self.port.readline()
                return

def run():

    if len(sys.argv) <= 1 or "-h" in sys.argv or "--help" in sys.argv:
        print "\n".join([i.lstrip() for i in """Usage
        =====

        tx.py -f=<frequency> -m=<mode>"

        Accepts data from stdin in raw 16-bit pcm format
        (stereo mode requires 2 channel, all others require 1 channel)

        Options
        -------

        -f=<frequency>

        Specify transmit frequency in Hz.

        -m=<mode>

        Mode may be AM or FM, WBFM, Stereo, LSB or USB.
        (not case sensitive)

        -d=<device>

        Specify USB/serial device of transmitter. Default is /dev/ttyUSB1.
        
        --transmit narrow band fm on 27MHz 
        sox test.wav -t raw -b 16 -r 12k --channels 1 - | ./tx.py -f=12e6 -m=fm -r=12000

        --transmit stereo FM on 88 MHz
        e.g. sox test.wav --channels 2 -t raw -b 16 -r 48k - | ./tx.py -f=88e6 -m=stereo -r=12000

        --transmit lower sideband on 10 MHz
        e.g. sox test.wav -t raw -b 16 -r 12k --channels 1 - | ./tx.py -f=100e6 -m=lsb -r=12000


        """.splitlines()])
        sys.exit(0)

    frequency = None
    mode = None
    device = "/dev/ttyUSB1"
    sample_rate=None
    audio_cutoff=None

    for arg in sys.argv[1:]:
        if arg.startswith("-f="):
            frequency = int(round(float(arg[3:])))
        elif arg.startswith("-m="):
            mode = arg[3:].upper()
        elif arg.startswith("-d="):
            device = arg[3:]
        elif arg.startswith("-r="):
            sample_rate = int(round(float(arg[3:])))
        elif arg.startswith("-l="):
            sample_rate = int(round(float(arg[3:])))

    if frequency is None:
        print "frequency must be specified"
        exit(0)

    if mode is None:
        print "mode must be specified"
        exit(0)

    if mode.upper() == "AM":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 12k"
            sample_rate = 12000
        modulator = AMModulator(
            frequency=frequency,
            sample_rate=sample_rate
        )
    elif mode.upper() == "USB":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 12k"
            sample_rate = 12000
        modulator = SSBModulator(
            frequency=frequency,
            sample_rate=sample_rate
        )
    elif mode.upper() == "LSB":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 12k"
            sample_rate = 12000
        modulator = SSBModulator(
            frequency=frequency,
            sample_rate=sample_rate,
            lsb = True
        )
    elif mode.upper() == "FM":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 12k"
            sample_rate = 12000
        modulator = FMModulator(
            frequency=frequency,
            sample_rate=sample_rate,
            cutoff=3000.0,
            fm_deviation=5000.0,
        )
    elif mode.upper() == "WBFM":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 48k"
            sample_rate = 48000
        modulator = WBFMModulator(
            frequency=frequency,
            sample_rate=sample_rate,
            cutoff=15000,
            fm_deviation=150000,
        )
    elif mode.upper() == "STEREO":
        if sample_rate is None:
            print "sample rate not specified"
            print "defaulting to 48k"
            sample_rate = 48000
        modulator = StereoModulator(
            frequency=frequency,
            sample_rate=sample_rate,
            cutoff=15000,
            fm_deviation=150000,
        )

    transmitter = Transmitter(device, modulator)
    transmitter.transmit(sys.stdin)
