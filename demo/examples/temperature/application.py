from demo.io_models.console import ConsoleOut
from chips.api.api import *

def application(chip):

    thermometer = Component("temperature.c")

    thermometer(
        chip, 
        inputs = {
            "i2c_in":chip.inputs["input_i2c"],
        }, 
        outputs = {
            "rs232_tx":chip.outputs["output_rs232_tx"],
            "i2c_out":chip.outputs["output_i2c"],
        },
        parameters = {})

if __name__ == "__main__":
    chip = Chip("Thermometer")
    Stimulus(chip, "input_i2c", "int", [0, 10, 0])
    Response(chip, "output_i2c", "int")
    ConsoleOut(chip, "output_rs232_tx")
    application(chip)
    chip.simulation_reset()
    chip.simulation_run()
