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
#include <math.h>

int eth_rx = input("eth_rx");
int eth_tx = output("eth_tx");

unsigned rs232_tx = output("rs232_tx");
int rs232_rx = input("rs232_rx");

int timer = input("timer");
int input_switches = input("switches");
int input_buttons = input("buttons");
int output_leds = output("leds");



void user_design(){

    unsigned start_time;
    int a;
    double value = 1.0;
    float fvalue = 1.0f;

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("calculate 1000 double multiplies\n");

    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        value *= 1.1;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n");

    puts("calculate 1000 double additions\n");
    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        value += 1.1;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n");

    puts("calculate 1000 double divisions\n");
    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        value /= 1.1;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n\n");

    puts("calculate 1000 float multiplies\n");
    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        fvalue *= 1.1f;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n");

    puts("calculate 1000 float additions\n");
    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        fvalue += 1.1f;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n");

    puts("calculate 1000 float divisions\n");
    start_time = fgetc(timer);
    for(a=0; a < 1000; a++){
        fvalue /= 1.1f;
    }
    print_double(1000.0 / (((unsigned)fgetc(timer)-start_time) * 50 * 0.001));
    puts(" Mflops\n\n");
}
