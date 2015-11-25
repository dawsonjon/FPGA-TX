# -*- coding: utf-8 -*-
from demo.components.server import server
from chips.api.api import *

def application(chip):

    keyboard_test = Component(
    r"""
    #include <stdio.h>
    #include <scan.h>
    #include <print.h>

    int ps2 = input("ps2");

    int rs232_tx = output("rs232_tx");
    int rs232_rx = input("rs232_rx");

    void main(){
        stdout = rs232_tx;
        stdin = rs232_rx;
        unsigned key;
        unsigned left_shift_pressed = 0;
        unsigned right_shift_pressed = 0;
        unsigned keys[] =       "q1\0\0\0zsaw2\0\0cxde43\0\0 vftr5\0\0nbhgy6\0\0\0mju78\0\0\0kio09\0\0\0\0l\0p";
        unsigned shift_keys[] = "Q!\0\0\0ZSAW\"\0\0CXDE$£\0 VFTR%\0\0NBHGY^\0\0\0MJU&*\0\0\0KIO)(\0\0\0\0L\0P";

        puts("\nChips Demo keyboard example\n");

        while(1){
            key = fgetc(ps2);
            if (key == 0xf0) { //release code
                key = fgetc(ps2);
                //check for releasing shift
                if(key == 0x12) left_shift_pressed = 0;
                if(key == 0x59) right_shift_pressed = 0;
                //ignore releasing any other key
            } else if(key == 0x12 || key == 0x59) {
                if(key == 0x12) left_shift_pressed = 1;
                if(key == 0x59) right_shift_pressed = 1;
            } else if(key == 0x5A) { //enter
                putc('\n');
            } else {
                if(left_shift_pressed || right_shift_pressed){
                    if(shift_keys[key-0x15]) putc(shift_keys[key-0x15]);
                } else {
                    if(keys[key-0x15]) putc(keys[key-0x15]);
                }
            }
        }
    }
    """, inline = True)

    keyboard_test(
        chip, 
        inputs = {
            "rs232_rx":chip.inputs["input_rs232_rx"],
            "ps2":chip.inputs["input_ps2"],
        },
        outputs = {
            "rs232_tx":chip.outputs["output_rs232_tx"],
        },
        parameters = {}
   )

