from chips.api.api import Stimulus, Response, Input, Output, Chip
from fpga_tx.build_tools import build_vivado
from fpga_tx.download_tools import vivado
import fpga_tx.flash_tools

build_tool = build_vivado
download_tool = vivado
flash_tool = fpga_tx.flash_tools.vivado
device =  "XC7A100T-CSG324-1"
board="Atlys"

def make_chip():
    chip = Chip("user_design")

    #create stimulus and response
    Input(chip, "input_rs232_rx")
    Output(chip, "output_rs232_tx")
    Output(chip, "output_tx_freq")
    Output(chip, "output_tx_am")
    Output(chip, "output_tx_ctl")

    return chip
