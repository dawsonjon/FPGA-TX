from chips.api.api import Component

def application(chip):

    c = Component("application.c")
    c(  
        chip = chip, 
        inputs = {
        },
        outputs = {
           "rs232_tx": chip.outputs["output_rs232_tx"],
        }
    )

