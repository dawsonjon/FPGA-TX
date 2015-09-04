from chips.api.api import Component, Wire
import os


def application(chip, eth_stim, rs232_stim, switches_stim, buttons_stim, 
    timer_stim, eth_response, rs232_response, led_response):

    local_dir = os.path.dirname(__file__)
    local_dir = os.path.abspath(local_dir)

    application = Component(os.path.join(local_dir, "application.c"))
    server = Component(os.path.join(local_dir, "server.c"))
    arbiter = Component(os.path.join(local_dir, "arbiter.c"))
    socket_tx = Wire(chip)
    socket_rx = Wire(chip)
    application_out = Wire(chip)
    server_out = Wire(chip)

    arbiter(  
        chip = chip, 
        inputs = {
           "in1": application_out,
           "in2": server_out,
        },
        outputs = {
           "out": rs232_response,
        },
    )

    application(  
        chip = chip, 
        inputs = {
           "socket":   socket_rx,
           "rs232_rx": rs232_stim,
           "switches": switches_stim,
           "buttons":  buttons_stim,
           "timer":    timer_stim,
        },
        outputs = {
           "socket":   socket_tx,
           "rs232_tx": application_out,
           "leds":     led_response,
        },
    )

    server(  
        chip = chip, 
        inputs = {
           "eth_rx":   eth_stim,
           "socket":   socket_tx,
        },
        outputs = {
           "eth_tx":   eth_response,
           "rs232_tx": server_out,
           #"rs232_tx": rs232_response,
           "socket":   socket_rx,
        }
    )

