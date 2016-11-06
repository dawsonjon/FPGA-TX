from chips.api.api import Stimulus, Response, Input, Output, Chip
from demo.build_tools import build_vivado
from demo.download_tools import vivado
import demo.flash_tools

build_tool = build_vivado
download_tool = vivado
flash_tool = demo.flash_tools.vivado
device =  "XC7A100T-CSG324-1"
board="Atlys"

def make_chip():
    chip = Chip("user_design")

    #create stimulus and response
    Input(chip, "input_eth_rx")
    Input(chip, "input_rs232_rx")
    Input(chip, "input_switches")
    Input(chip, "input_buttons")
    Input(chip, "input_timer")
    Input(chip, "input_i2c")
    Input(chip, "input_ps2")

    Output(chip, "output_eth_tx")
    Output(chip, "output_rs232_tx")
    Output(chip, "output_leds")
    Output(chip, "output_led_r")
    Output(chip, "output_led_g")
    Output(chip, "output_led_b")
    Output(chip, "output_seven_segment_cathode")
    Output(chip, "output_seven_segment_annode")
    Output(chip, "output_i2c")
    Output(chip, "output_vga")
    Output(chip, "output_audio")
    Output(chip, "output_tx_freq")
    Output(chip, "output_tx_am")
    Output(chip, "output_tx_ctl")

    return chip
