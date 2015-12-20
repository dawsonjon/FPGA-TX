from chips.api.api import *

def application(chip):

    enigma = Component("application.c")
    enigma(
        chip, 
        inputs = {
            "rs232_in" : chip.inputs["input_rs232_rx"],
        },
        outputs = {
            "rs232_out" : chip.outputs["output_rs232_tx"],
        },
    )
