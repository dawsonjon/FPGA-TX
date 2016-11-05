from chips.api.api import *
from chips.utils.debugger import Debugger

def application(chip):

    eth = Component("application.c")
    eth(
        chip, 
        inputs = {
            "rs232_rx":chip.inputs["input_rs232_rx"],
        },
        outputs = {
            "audio_out" : chip.outputs["output_audio"],
            "freq_out" : chip.outputs["output_tx_freq"],
            "am_out" : chip.outputs["output_tx_am"],
            "ctl_out" : chip.outputs["output_tx_ctl"],
            "rs232_tx": chip.outputs["output_rs232_tx"],
        },
    )

if __name__ == "__main__":
    print "running application testbench"

    commands = "f100000000\n"+"b"+chr(2)+"".join([chr(i) for i in [0, 0, 255, 255]])

    test_chip = Chip("test chip")
    rs232_in = Stimulus(test_chip, "input_rs232_rx", "int", [ord(i) for i in commands])
    audio_out = Response(test_chip, "output_audio", "int")
    freq_out = Response(test_chip, "output_tx_freq", "int")
    am_out = Response(test_chip, "output_tx_am", "int")
    ctl_out = Response(test_chip, "output_tx_ctl", "int")
    rs232_out = Response(test_chip, "output_rs232_tx", "int")
    application(test_chip)
    Debugger(test_chip)
