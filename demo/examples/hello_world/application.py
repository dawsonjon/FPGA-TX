from demo.components.server import server
from chips.api.api import *

def application(chip):

    hello_world = Component(
    """
    #include <stdio.h>
    stdout = output("rs232_tx");

    void main(){
        puts("Hello World!\n");
    }
    """, inline = True)

    hello_world(
        chip, 
        inputs = {}, 
        outputs = {"rs232_tx":chip.outputs["output_rs232_tx"]},
        parameters = {})

