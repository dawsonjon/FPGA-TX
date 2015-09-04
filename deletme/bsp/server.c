////////////////////////////////////////////////////////////////////////////////
//
//  CHIPS-2.0 TCP/IP SERVER
//
//  :Author: Jonathan P Dawson
//  :Date: 17/10/2013
//  :email: chips@jondawson.org.uk
//  :license: MIT
//  :Copyright: Copyright (C) Jonathan P Dawson 2013
//
//  A TCP/IP stack that supports a single socket connection.
//
////////////////////////////////////////////////////////////////////////////////

int output_eth_tx = output("eth_tx");
int output_socket = output("socket");
int input_eth_rx = input("eth_rx");
int input_socket = input("socket");

void put_eth(unsigned i){
	fputc(output_eth_tx, i);
}
void put_socket(unsigned i){
	fputc(output_socket, i);
}
unsigned get_eth(){
	return fgetc(input_eth_rx);
}
unsigned rdy_eth(){
	return ready(input_eth_rx);
}
unsigned get_socket(){
	return fgetc(input_socket);
}
#include "server.h"
