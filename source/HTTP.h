unsigned socket_high = 1;
unsigned socket_data;

void socket_put_char(char x){
	if(socket_high){
		socket_high = 0;
		socket_data = x << 8;
	} else {
		socket_high = 1;
		socket_data |= x & 0xff;
		put_socket(socket_data);
	}
}

void socket_flush(){
	if(!socket_high) put_socket(socket_data);
	socket_high = 1;
}

void socket_put_string(unsigned string[]){
	unsigned i;
	while(string[i]){
		socket_put_char(string[i]);
		i++;
	}
}

void socket_put_decimal(unsigned value){
	unsigned digit_0 = '0';
	unsigned digit_1 = '0';
	unsigned digit_2 = '0';
	unsigned digit_3 = '0';
	unsigned digit_4 = '0';

	while(value >= 10000){
		digit_4++;
		value -= 10000;
	}
	if(digit_4 != '0') socket_put_char(digit_4);
	while(value >= 1000){
		digit_3++;
		value -= 1000;
	}
	if(digit_3 != '0') socket_put_char(digit_3);
	while(value >= 100){
		digit_2++;
		value -= 100;
	}
	if(digit_2 != '0') socket_put_char(digit_2);
	while(value >= 10){
		digit_1++;
		value -= 10;
	}
	if(digit_1 != '0') socket_put_char(digit_1);
	while(value >= 1){
		digit_0++;
		value -= 1;
	}
	socket_put_char(digit_0);
}


void HTTP_GET_response(int body[]){
	unsigned header_length;
	unsigned body_length;
	unsigned length;
	unsigned element;
	unsigned header[] = 
"HTTP/1.1 200 OK\r\n\
Date: Thu Oct 31 19:16:00 2013\r\n\
Server: chips-web/0.0\r\n\
Content-Type: text/html\r\n\
Content-Length: ";

	//count body length
	body_length = 0;
	while(body[body_length]) body_length++;
	//count header length
	header_length = 0;
	while(header[header_length]) header_length++;
	//count total length
	length = body_length + header_length + 5;
	//header length depends on body length
	if(body_length > 9) length++;
	if(body_length > 99) length++;
	if(body_length > 999) length++;
	//Send length to server
	put_socket(length);
	//Send header to server
	socket_put_string(header);
	socket_put_decimal(body_length);
	socket_put_string("\r\n\r\n");
	//Send body to server
	socket_put_string(body);
	//Send last byte if there are an odd number
	socket_flush();
}
