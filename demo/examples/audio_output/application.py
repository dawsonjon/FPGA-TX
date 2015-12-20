from demo.components.server import server
from chips.api.api import *

def application(chip):

    eth = Component("application.c")
    eth(
        chip, 
        inputs = {
            "eth_in" : chip.inputs["input_eth_rx"],
        },
        outputs = {
            "eth_out" : chip.outputs["output_eth_tx"],
            "audio_out" : chip.outputs["output_audio"],
        },
    )
