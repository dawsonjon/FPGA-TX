from chips.api.api import Component
import os


def application(chip, eth_stim, rs232_stim, switches_stim, buttons_stim, 
    timer_stim, eth_response, rs232_response, led_response):

    local_dir = os.path.dirname(__file__)
    local_dir = os.path.abspath(local_dir)

    c = Component(os.path.join(local_dir, "application.c"))
    return c(  
        chip = chip, 
        inputs = {
           "eth_rx":   eth_stim,
           "rs232_rx": rs232_stim,
           "switches": switches_stim,
           "buttons":  buttons_stim,
           "timer":    timer_stim,
        },
        outputs = {
           "eth_tx":   eth_response,
           "rs232_tx": rs232_response,
           "leds":     led_response,
        },
        debug=False
    )

