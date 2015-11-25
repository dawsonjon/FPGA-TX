from demo.components.server import server
from chips.api.api import *

def application(chip):

    knight_rider_lights = Component(
    """
    #include <stdio.h>
    #include <scan.h>
    #include <print.h>

    int led_r = output("led_r");
    int led_g = output("led_g");
    int led_b = output("led_b");
    int rs232_tx = output("rs232_tx");
    int rs232_rx = input("rs232_rx");

    void set_color(unsigned r, unsigned g, unsigned b){
        fputc(r, led_r);
        fputc(g, led_g);
        fputc(b, led_b);
    }

    void main(){
        stdout = rs232_tx;
        stdin = rs232_rx;

        unsigned red, green, blue;
        
        puts("Chips Demo tri-color LED example\n");
        while(1){
            puts("enter red level (hex 0-FF)\n");
            red = scan_uhex();
            print_uhex(red); puts("\n");
            puts("enter green level (hex 0-FF)\n");
            green = scan_uhex();
            print_uhex(green); puts("\n");
            puts("enter blue level (hex 0-FF)\n");
            blue = scan_uhex();
            print_uhex(blue); puts("\n");
            set_color(red, green, blue);
        }
    }
    """, inline = True)

    knight_rider_lights(
        chip, 
        inputs = {
            "rs232_rx":chip.inputs["input_rs232_rx"],
        },
        outputs = {
            "led_r":chip.outputs["output_led_r"],
            "led_g":chip.outputs["output_led_g"],
            "led_b":chip.outputs["output_led_b"],
            "rs232_tx":chip.outputs["output_rs232_tx"],
        },
        parameters = {})

