from chips.api.api import Component, Wire
import os


def application(chip):

    application = Component("application.c")
    server      = Component("server.c")
    arbiter     = Component("arbiter.c")

    socket_tx       = Wire(chip)
    socket_rx       = Wire(chip)
    application_out = Wire(chip)
    server_out      = Wire(chip)

    arbiter(  
        chip = chip, 
        inputs = {
           "in1": application_out,
           "in2": server_out,
        },
        outputs = {
           "out": chip.outputs["output_rs232_tx"],
        },
    )

    application(  
        chip = chip, 
        inputs = {
           "socket":   socket_rx,
           "rs232_rx": chip.inputs["input_rs232_rx"],
           "switches": chip.inputs["input_switches"],
           "buttons":  chip.inputs["input_buttons"],
        },
        outputs = {
           "socket":   socket_tx,
           "rs232_tx": application_out,
           "leds":      chip.outputs["output_leds"],
        },
    )

    server(  
        chip = chip, 
        inputs = {
           "eth_rx":   chip.inputs["input_eth_rx"],
           "socket":   socket_tx,
        },
        outputs = {
           "eth_tx":   chip.outputs["output_eth_tx"],
           "rs232_tx": server_out,
           "socket":   socket_rx,
        }
    )

