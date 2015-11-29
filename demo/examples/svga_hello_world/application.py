from demo.components.server import server
from chips.api.api import *

def application(chip):

    vga = Component("application.c")
    vga(
        chip, 
        inputs = {
        },
        outputs = {
            "vga_out" : chip.outputs["output_vga"],
            "rs232_out" : chip.outputs["output_rs232_tx"],
        },
    )
