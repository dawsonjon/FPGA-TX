from demo.components.server import server
from chips.api.api import *

def application(chip):

    slow_count = Component(
    """
    int value_out = output("value");
    void main(){
        int count = 0;
        while(1){
            fputc(0xffff & count++, value_out);
            wait_clocks(50000000);
        }
    }
    """, inline = True)

    seven_segment = Component(
    """
    int value_in = input("value");
    int cathode_out = output("cathode");
    int annode_out = output("annode");
    int pattern[] = {
        0x3F, 0x06, 0x5B, 0x4F,
        0x66, 0x6D, 0x7D, 0x07,
        0x7F, 0x6F, 0x77, 0x7C,
        0x39, 0x5e, 0x79, 0x71
    };
    void main(){
        int digit, temp, value, annode;
        while(1){
            if(ready(value_in)){
                value = fgetc(value_in);
            }
            temp = value;
            annode = 1;
            for(digit = 0; digit < 8; digit++){
                fputc(pattern[temp & 0xf], cathode_out);
                fputc(annode, annode_out);
                annode <<= 1;
                temp >>= 4;
                wait_clocks(50000000/400);
            }
        }

    }
    """, inline = True)

    value = Wire(chip)

    slow_count(
        chip, 
        inputs = {
        }, 
        outputs = {
            "value":value,
        },
        parameters = {})

    seven_segment(
        chip, 
        inputs = {
            "value":value,
        }, 
        outputs = {
            "cathode":chip.outputs["output_seven_segment_cathode"],
            "annode":chip.outputs["output_seven_segment_annode"],
        },
        parameters = {})

