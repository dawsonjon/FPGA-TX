from chips.api.api import Stimulus, Response, Input, Output, Chip
from demo.build_tools import build_ise
from demo.download_tools import digilent

build_tool = build_ise
download_tool = digilent
board="Atlys"
device = "XC6Slx45-CSG324"

def make_chip():
    chip = Chip("user_design")

    #create stimulus and response
    Input(chip, "input_eth_rx")
    Input(chip, "input_rs232_rx")
    Input(chip, "input_switches")
    Input(chip, "input_buttons")
    Input(chip, "input_timer")
    Input(chip, "input_ps2")

    Output(chip, "output_eth_tx")
    Output(chip, "output_rs232_tx")
    Output(chip, "output_leds")

    return chip
