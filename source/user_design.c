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

int find(unsigned string[], unsigned search, unsigned start){
	int value = start;
	while(string[value]){
	       if(string[value] == search) return value;
	       value++;
	}
	return -1;
}

void user_design()
{
	//simple echo application
	unsigned length;
	unsigned i, index;
	unsigned data[1460];
	unsigned word;
	unsigned switches = 0;
	unsigned buttons = 0;
	unsigned leds = 0;

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
	<input type=\"checkbox\" name=\"led1\" value=\"A\">led 0</input>\
	<input type=\"checkbox\" name=\"led2\" value=\"B\">led 1</input>\
	<input type=\"checkbox\" name=\"led3\" value=\"C\">led 2</input>\
	<input type=\"checkbox\" name=\"led4\" value=\"D\">led 3</input>\
	<button type=\"sumbit\" value=\"Submit\">Update LEDs</button>\
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

		//Get LED values
		//==============
		leds = 0;
		index=find(data, '?', 0);
		if(index != -1){
			index ++;
			if(find(data, 'A', index) != -1) leds |= 1;
			if(find(data, 'B', index) != -1) leds |= 2;
			if(find(data, 'C', index) != -1) leds |= 4;
			if(find(data, 'D', index) != -1) leds |= 8;
		}
		output_leds(leds);

		//read switch values
		//==================
		switches = ~input_switches();
		//find first ':'
		index = find(page, ':', 0);
		index+=2;
		//insert switch values
		if(switches & 1) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 2) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 4) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(switches & 8) page[index] = '0';
		else page[index] = '1';

		//read button values
		//==================
		buttons = ~input_buttons();
		//find next ':'
		index = find(page, ':', index+1);
		index+=2;
		//insert button values
		if(buttons & 1) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 2) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 4) page[index] = '0';
		else page[index] = '1';
		index ++;
		if(buttons & 8) page[index] = '0';
		else page[index] = '1';

		HTTP_GET_response(page);

	}

        //dummy access to peripherals
	i = input_rs232_rx();
	output_rs232_tx(1);
}
