from demo.components.server import server
from chips.api.api import *

def application(chip):

    w = Wire(chip)
    server(chip, 
        chip.inputs["input_eth_rx"], 
        chip.outputs["output_eth_tx"],
        w,
        w,
        chip.outputs["output_rs232_tx"]
    )
