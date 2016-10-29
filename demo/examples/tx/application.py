from demo.components.server import server
from chips.api.api import *

def application(chip):

    eth = Component("application.c")
    eth(
        chip, 
        inputs = {
            "eth_in" : chip.inputs["input_eth_rx"],
            "rs232_rx":chip.inputs["input_rs232_rx"],
        },
        outputs = {
            "eth_out" : chip.outputs["output_eth_tx"],
            "audio_out" : chip.outputs["output_audio"],
            "freq_out" : chip.outputs["output_tx_freq"],
            "am_out" : chip.outputs["output_tx_am"],
            "rs232_tx": chip.outputs["output_rs232_tx"],
        },
    )
