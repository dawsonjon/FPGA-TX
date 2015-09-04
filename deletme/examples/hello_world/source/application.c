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

    puts("Hello World!\n");

}
