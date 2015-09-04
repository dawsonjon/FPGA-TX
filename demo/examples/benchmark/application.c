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



void application(){

    unsigned start_time, finish_time;
    int i;
    float fvalue = 1.0f;
    const float clock_frequency = 50.0f;
    const float clock_period = 1.0f/clock_frequency;

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("calculate 1000 floating point adds\n");
    start_time = fgetc(timer);
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
    }
    finish_time = fgetc(timer);
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");

    puts("calculate 1000 floating point multiplies\n");
    start_time = fgetc(timer);
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
    }
    finish_time = fgetc(timer);
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");

    puts("calculate 1000 floating point divides\n");
    start_time = fgetc(timer);
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
    }
    finish_time = fgetc(timer);
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");


}
