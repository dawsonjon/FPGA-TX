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
	//simple echo application
	unsigned length;
	unsigned i, index;
	unsigned data[1460];
	unsigned word;
	unsigned switches = 0;
	unsigned buttons = 0;

	unsigned page[] = 
"<html>\
<head>\
<title>Chips-2.0 SP605 Demo</title>\
</head>\
<body>\
<h1>Chips-2.0 SP605 Demo</h1>\
<p>Welcome to the Chips-2.0 SP605 Demo!</p>\
<p>Switch Status: 0000</p>\
<p>Button Status: 0000</p>\
<form>\
<input type=\"checkbox\" name=\"led1\" value=\"0\">led 0<br>\
<input type=\"checkbox\" name=\"led2\" value=\"0\">led 1<br>\
<input type=\"checkbox\" name=\"led3\" value=\"0\">led 2<br>\
<input type=\"checkbox\" name=\"led4\" value=\"0\">led 3\
<input type=\"sumbit\" value=\"Update\">\
</form>\
<p>This <a href=\"https://github.com/dawsonjon/SP605-Demo\">project</a>\
 is powered by <a href=\"https://github.com/dawsonjon/Chips-2.0\">Chips-2.0</a>.</p>\
</body>\
</html>";
 
	while(1){

		length = input_socket();
		index = 0;
		for(i=0;i<length;i+=2){
			data[index] = input_socket();
			index++;
		}

		//read switch values
		switches = input_switches();
		//find first ':'
		index = 0;
		while(1){
			if(page[index] == ':') break;
			index++;
		}
		index+=2;
		//insert switch values
		if(switches & 8) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 4) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 2) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 1) page[index] = '0';
		else page[index] = '1';

		//read button values
		buttons = input_buttons();
		//find next ':'
		while(1){
			if(page[index] == ':') break;
			index++;
		}
		index+=2;
		//insert button values
		if(buttons & 8) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 4) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 2) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 1) page[index] = '0';
		else page[index] = '1';

		HTTP_GET_response(page);

	}

        //dummy access to peripherals
	output_leds(0x5);
	i = input_rs232_rx();
	output_rs232_tx(1);
}
