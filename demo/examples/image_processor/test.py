from chips.api.api import Component, Chip, Input, Output, Stimulus, Response
from demo.rundemo import build_xst, compile_user_design, download_digilent
import sys
import os


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

if len(sys.argv) <= 1:
    print "Usage example board *(simulate | compile | build)"
else:
    example = sys.argv[1]
    board = sys.argv[2]

    #create a chip
    #
    chip = Chip("user_design")

    #create stimulus and response
    eth_stim = Stimulus(chip, "input_eth_rx", "int", [0])
    rs232_stim = Stimulus(chip, "input_rs232_rx", "int", [0])
    switches_stim = Stimulus(chip, "input_switches", "int", [0, 1, 2, 3, 4])
    buttons_stim = Stimulus(chip, "input_buttons", "int", [0])
    timer_stim = Stimulus(chip, "input_timer", "int", [0, 1])
    eth_response = Response(chip, "output_eth_tx", "int")
    rs232_response = ConsoleOut(chip, "output_rs232_tx")
    led_response = Leds(chip, "output_leds")

    #Create models of user_design inputs

    application = __import__("demo.examples.%s.application"%example, globals(), locals(), ["application"], -1)
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

        file_list = [
            "user_design.v",
            "chips_lib.v",
            "application.v",
            "arbiter.v",
            "server.v",
        ]

        build_xst(file_list, os.path.join("bsp", board))

    if "download" in sys.argv:

        download_digilent(board.title())
