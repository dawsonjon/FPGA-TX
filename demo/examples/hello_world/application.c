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

int eth_rx = input("eth_rx");
int eth_tx = output("eth_tx");

unsigned rs232_tx = output("rs232_tx");
int rs232_rx = input("rs232_rx");

int timer = input("timer");
int input_switches = input("switches");
int input_buttons = input("buttons");
int output_leds = output("leds");



void application(){

    int a;

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("Hello World!\n");
    fputc(0xaa, output_leds);

}
