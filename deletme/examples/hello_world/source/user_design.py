from chips.api.api import Component, Chip, Input, Output, Stimulus, Response

def make_chip():

    chip = Chip("user_design")
    application = Component("application.c")

    eth_values = Response(chip, "eth_tx", "int")
    rs232_values = Response(chip, "rs232_tx", "int")
    led_values = Response(chip, "led", "int")

    application(

        chip = chip, 

        inputs = {
            "eth_rx": Stimulus(chip, "eth_rx", "int", [0]),
            "rs232_rx": Stimulus(chip, "rs232_rx", "int", [0]),
            "switches": Stimulus(chip, "switches", "int", [0, 1, 2, 3, 4]),
            "buttons": Stimulus(chip, "buttons", "int", [0]),
            "timer": Stimulus(chip, "timer", "int", [0, 1]),
        },

        outputs = {
            "eth_tx": eth_values,
            "rs232_tx": rs232_values,
            "leds": led_values,
        }
    )

    return chip

