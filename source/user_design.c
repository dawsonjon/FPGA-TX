////////////////////////////////////////////////////////////////////////////////
//
//  CHIPS-2.0 USER DESIGN
//
//  :Author: Jonathan P Dawson
//  :Date: 17/10/2013
//  :email: chips@jondawson.org.uk
//  :license: MIT
//  :Copyright: Copyright (C) Jonathan P Dawson 2013
//
//  Simple web app demo.
//
////////////////////////////////////////////////////////////////////////////////

void put_socket(unsigned i){
	output_socket(i);
}
#include "HTTP.h"

void user_design()
{
    unsigned i, length;
    unsigned data[1024];

    while (1) {
    length = input_socket();
    for(i=0; i<length; i+=2){
		data[i] = input_socket();
	}

    output_socket(length);
    for(i=0; i<length; i+=2){
		output_socket(data[i]);
	}
    }

        //dummy access to peripherals
    i = input_switches();
    i = input_buttons();
    output_leds(0x55);
    output_rs232_tx(0x55);
    i=input_rs232_rx();
}
