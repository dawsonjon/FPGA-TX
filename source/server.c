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

input_eth_rx  =   input ("eth_rx");
output_eth_tx =   output("eth_tx");

input_socket    =   input ("socket");
output_socket   =   output("socket");


void put_eth(unsigned i){
	fputc(i, output_eth_tx);
}
void put_socket(unsigned i){
	fputc(i,output_socket);
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
