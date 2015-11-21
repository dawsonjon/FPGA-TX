from chips.api.api import Component, Chip, Input, Output, Stimulus, Response
from chips.compiler.exceptions import C2CHIPError
from demo.rundemo import build_xst, compile_user_design, download_digilent
from pytun import TunTapDevice, IFF_TAP, IFF_NO_PI
import sys
import os
import select

tap = TunTapDevice(flags=IFF_TAP|IFF_NO_PI, name="tap0")
tap.addr = '192.168.1.0'
tap.netmask = '255.255.255.0'
tap.mtu = 1500
tap.up()

class ConsoleOut(Output):
    def __init__(self, chip, name):
        Output.__init__(self, chip, name)
    def data_sink(self, data):
        sys.stdout.write(chr(data))
        sys.stdout.flush()

class Leds(Output):
    def __init__(self, chip, name):
        Output.__init__(self, chip, name)
    def data_sink(self, data):
        print "leds:", bin(data)

class NetworkOut(Output):
    def __init__(self, chip, name):
        Output.__init__(self, chip, name)
        self.packet_len=0
        self.buff=""
    def data_sink(self, data):
        if not self.packet_len:
            self.packet_len = data
        else:
            byte = (data >> 8) & 0xff
            self.buff += chr(byte)
            self.packet_len -= 1
            if self.packet_len:
                byte = data & 0xff
                self.buff += chr(byte)
                self.packet_len -= 1
        if not self.packet_len and self.buff:
            tap.write(self.buff)
            self.buff = ""

class NetworkIn(Input):
    def __init__(self, chip, name):
        Input.__init__(self, chip, name)
        self.packet_len=0
        self.buff = ""
    def data_source(self):
        if not self.buff:
           self.buff = tap.read(1500)
           #for i, char in enumerate(self.buff):
               #print i, hex(ord(char))
           return len(self.buff)
        else:
           byte = ord(self.buff[0])
           word = byte << 8
           self.buff = self.buff[1:]
           if self.buff:
               byte = ord(self.buff[0])
               word |= byte & 0xff
               self.buff = self.buff[1:]
           return word
    def ready(self):
        return True

if len(sys.argv) <= 1:
    print "Usage example board *(simulate | compile | build)"
else:
    example = sys.argv[1]
    board = sys.argv[2]

    #create a chip
    #
    chip = Chip("user_design")

    #create stimulus and response
    eth_stim = NetworkIn(chip, "input_eth_rx")
    rs232_stim = Stimulus(chip, "input_rs232_rx", "int", [0])
    switches_stim = Stimulus(chip, "input_switches", "int", [0, 1, 2, 3, 4])
    buttons_stim = Stimulus(chip, "input_buttons", "int", [0])
    timer_stim = Stimulus(chip, "input_timer", "int", [0, 1])
    eth_response = NetworkOut(chip, "output_eth_tx")
    rs232_response = ConsoleOut(chip, "output_rs232_tx")
    led_response = Leds(chip, "output_leds")

    #Create models of user_design inputs

    application = __import__("demo.examples.%s.application"%example, globals(), locals(), ["application"], -1)
    try:
        application.application(
            chip, 
            eth_stim,
            rs232_stim,
            switches_stim,
            buttons_stim,
            timer_stim,
            eth_response,
            rs232_response,
            led_response,
        )

        if "simulate" in sys.argv:
            chip.simulation_reset()
            chip.simulation_run()

        if "vsim" in sys.argv:
            chip.generate_verilog()
            chip.generate_testbench()
            chip.compile_iverilog(True)

        if "compile" in sys.argv:
            compile_user_design(chip)

        if "build" in sys.argv:

            build_xst(chip, os.path.join("bsp", board))

        if "download" in sys.argv:
            download_digilent(board.title())

    except C2CHIPError as e:
        print e
