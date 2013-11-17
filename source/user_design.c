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
	while(1){

		length = input_socket();
		index = 0;
		for(i=0;i<length;i+=2){
			data[index] = input_socket();
			index++;
		}

		HTTP_GET_response(
"<html>\
<head>\
<title>Chips-2.0 SP605 Demo</title>\
</head>\
<body>\
<h1>Chips-2.0 SP605 Demo</h1>\
<p>Welcome to the Chips-2.0 SP605 Demo!</p>\
<p>This <a href=\"https://github.com/dawsonjon/SP605-Demo\">project</a> \
is powered by <a href=\"https://github.com/dawsonjon/Chips-2.0\">Chips-2.0</a>.</p>\
</body>\
</html>"
		);

	}

        //dummy access to peripherals
	output_leds(0x5);
	i = input_switches();
	i = input_rs232_rx();
	output_rs232_tx(1);
}
