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
//  Top level ATLYS design
//
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <print.h>

int socket_rx = input("socket");
int socket_tx = output("socket");

unsigned rs232_tx = output("rs232_tx");
int rs232_rx = input("rs232_rx");

int timer = input("timer");
int input_switches = input("switches");
int input_buttons = input("buttons");
int output_leds = output("leds");

void application()
{
	//simple echo application
	unsigned i, j, pixel;
	unsigned line[256];
	unsigned above[256];
	unsigned below[256];
    unsigned length, data;

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("Image Processing Chips-2.0 demo!\n");
	puts("Connect to 192.168.1.1 port 80\n");
	while(1){

        fputc(fgetc(socket_rx), socket_tx);

        
        /*for(j=0; j<256; j++){

            for(i=0; i<256; i++){
                if (j < 255) {
                    below[i] = fgetc(socket_rx);
                } else {
                    below[i] = 0;
                }
                line[i] = below[i];
                if (j > 1) {
                    above[i] = line[i];
                } else {
                    above[i] = 0;
                }
            }

            for(i=0; i<256; i++){
                pixel =  line[i] << 2;
                if(i>0) pixel -= line[i-1];
                if(i<255) pixel -= line[i+1];
                pixel -= above[i];
                if(i>0) pixel -= above[i-1];
                if(i<255) pixel -= above[i+1];
                pixel -= below[i];
                if(i>0) pixel -= below[i-1];
                if(i<255) pixel -= below[i+1];
                fputc(pixel, socket_tx);
            }
        }*/
        
    }
}

