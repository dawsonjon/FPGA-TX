from demo.components.server import server
from chips.api.api import *

def application(chip):

    eth = Component("application.c")
    eth(
        chip, 
        inputs = {
            "eth_in" : chip.inputs["input_eth_rx"],
            "am_in" : chip.inputs["input_radio_am"],
            "fm_in" : chip.inputs["input_radio_fm"],
            "rs232_rx":chip.inputs["input_rs232_rx"],
        },
        outputs = {
            "eth_out" : chip.outputs["output_eth_tx"],
            "audio_out" : chip.outputs["output_audio"],
            "frequency_out" : chip.outputs["output_radio_frequency"],
            "samples_out" : chip.outputs["output_radio_average_samples"],
            "rs232_tx":chip.outputs["output_rs232_tx"],
        },
    )
