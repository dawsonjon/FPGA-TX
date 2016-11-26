from chips.api.api import *
from chips.utils.debugger import Debugger

def application(chip):

    eth = Component("application.c")
    eth(
        chip, 
        inputs = {
            "rs232_rx":chip.inputs["input_rs232_rx"],
            "gps_rx":chip.inputs["input_gps_rx"],
            "gps_count":chip.inputs["input_gps_count"],
        },
        outputs = {
            "freq_out" : chip.outputs["output_tx_freq"],
            "am_out" : chip.outputs["output_tx_am"],
            "ctl_out" : chip.outputs["output_tx_ctl"],
            "rs232_tx": chip.outputs["output_rs232_tx"],
            "gps_tx": chip.outputs["output_gps_tx"],
            "leds": chip.outputs["output_leds"],
        },
    )
