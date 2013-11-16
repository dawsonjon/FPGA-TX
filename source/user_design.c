void put_socket(unsigned i){

	output_rs232_tx('g');
	output_socket(i);
	output_rs232_tx('h');
}

#include "HTTP.h"

void user_design()
{
	//simple echo application
	unsigned length;
	unsigned i, index;
	unsigned data[1460];
	unsigned word;
	while(1){

		length = input_socket();
		index = 0;
		for(i=0;i<length;i+=2){
			data[index] = input_socket();
			index++;
		}

		output_rs232_tx('a');

		HTTP_GET_response(
"<html>\
<head>\
	<title>Chips 2.0 SP605 Demo</title>\
</head>\
<body>\
	Hello World, this is a very simple HTML document.\
</body>\
</html>");
		output_rs232_tx('b');

	}

        //dummy access to peripherals
	output_leds(0x5);
	input_rs232_rx();
	output_rs232_tx(1);
}
