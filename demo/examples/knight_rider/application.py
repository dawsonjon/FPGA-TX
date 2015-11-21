from demo.components.server import server
from chips.api.api import *

def application(chip):

    knight_rider_lights = Component(
    """
    int leds = output("leds");
    void main(){
        unsigned shifter = 1;
        while(1){
            while(shifter != 0x80){
                fputc(shifter, leds);
                shifter <<= 1;
                wait_clocks(5000000);
            }
            while(shifter != 0x01){
                fputc(shifter, leds);
                shifter >>= 1;
                wait_clocks(5000000);
            }
        }
    }
    """, inline = True)

    knight_rider_lights(
        chip, 
        inputs = {}, 
        outputs = {"leds":chip.outputs["output_leds"]},
        parameters = {})

