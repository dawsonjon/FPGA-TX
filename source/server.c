void put_eth(unsigned i){
	output_eth_tx(i);
}
void put_socket(unsigned i){
	output_socket(i);
}
unsigned get_eth(){
	return input_eth_rx();
}
unsigned rdy_eth(){
	return ready_eth_rx();
}
unsigned get_socket(){
	return input_socket();
}

#include "server.h"
