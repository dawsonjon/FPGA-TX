from demo.components.server import server
from chips.api.api import *
from chips.components.components import *

def application(
        chip, 
        eth_in,
        rs232_in,
        switches_in,
        buttons_in,
        timer_in,
        eth_out,
        rs232_out,
        led_out
    ):

    w = Wire(chip)
    server(chip, 
        eth_in, 
        eth_out,
        w,
        w,
        rs232_out
    )

    constant(chip, 0xaa, out=led_out)
    discard(chip, rs232_in)
    discard(chip, switches_in)
    discard(chip, buttons_in)
    discard(chip, timer_in)

