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

#include <stdio.h>
#include <print.h>
#include "server.h"

void put_eth(unsigned i){
	fputc(i, output_eth_tx);
}
unsigned get_eth(){
	return fgetc(input_eth_rx);
}
unsigned rdy_eth(){
	return ready(input_eth_rx);
}

////////////////////////////////////////////////////////////////////////////////
// TCP-IP GLOBALS
//

unsigned tx_packet[512];

////////////////////////////////////////////////////////////////////////////////
// Checksum calculation routines
//
 
//store checksum in a global variable
//unsigneds are 16 bits, so use an array of 2 to hold a 32 bit number
 
long unsigned checksum;
 
//Reset checksum before calculation
//
 
void reset_checksum(){
  checksum = 0;
}
 
//Add 16 bit data value to 32 bit checksum value
//
 
void add_checksum(unsigned data){
  checksum += data;
  if(checksum & 0x10000ul){
	  checksum &= 0xffffu;
	  checksum += 1;
  }
}
 
//Retrieve the calculated checksum
//
 
unsigned check_checksum(){
  return ~checksum;
}

////////////////////////////////////////////////////////////////////////////////
// Data Link Layer - Ethernet
//

void put_ethernet_packet(
		unsigned packet[], 
		unsigned number_of_bytes,
		unsigned destination_mac_address_hi,
		unsigned destination_mac_address_med,
		unsigned destination_mac_address_lo,
		unsigned protocol){

        unsigned byte, index;

        //set up ethernet header
	packet[0] = destination_mac_address_hi;
	packet[1] = destination_mac_address_med;
	packet[2] = destination_mac_address_lo;
	packet[3] = local_mac_address_hi;
	packet[4] = local_mac_address_med;
	packet[5] = local_mac_address_lo;
	packet[6] = protocol;

	put_eth(number_of_bytes);
	index = 0;
	for(byte=0; byte<number_of_bytes; byte+=2){
		put_eth(packet[index]);
		index ++;
	}
}

//Get a packet from the ethernet interface
//Will reply to arp requests
//returns the number of bytes read which may be 0
unsigned get_ethernet_packet(unsigned packet[]){

    unsigned number_of_bytes, index;
	unsigned byte;

	if(!rdy_eth()) return 0;


	number_of_bytes = get_eth();
	index = 0;
	for(byte=0; byte<number_of_bytes; byte+=2){
		packet[index] = get_eth();
		index ++;
	}

        //Filter out packets not meant for us
	if(packet[0] != local_mac_address_hi && packet[0] != 0xffffu) return 0;
	if(packet[1] != local_mac_address_med && packet[1] != 0xffffu) return 0;
	if(packet[2] != local_mac_address_lo && packet[2] != 0xffffu) return 0;

	//Process ARP requests within the data link layer
	if (packet[6] == 0x0806){ //ARP
		//respond to requests
		if (packet[10] == 0x0001){
			//construct and send an ARP response
			tx_packet[7] = 0x0001; //HTYPE ethernet
			tx_packet[8] = 0x0800; //PTYPE IPV4
			tx_packet[9] = 0x0604; //HLEN, PLEN
			tx_packet[10] = 0x0002; //OPER=REPLY
			tx_packet[11] = local_mac_address_hi; //SENDER_HARDWARE_ADDRESS
			tx_packet[12] = local_mac_address_med; //SENDER_HARDWARE_ADDRESS
			tx_packet[13] = local_mac_address_lo; //SENDER_HARDWARE_ADDRESS
			tx_packet[14] = local_ip_address_hi; //SENDER_PROTOCOL_ADDRESS
			tx_packet[15] = local_ip_address_lo; //SENDER_PROTOCOL_ADDRESS
			tx_packet[16] = packet[11]; //TARGET_HARDWARE_ADDRESS
			tx_packet[17] = packet[12]; //
			tx_packet[18] = packet[13]; //
			tx_packet[19] = packet[14]; //TARGET_PROTOCOL_ADDRESS
			tx_packet[20] = packet[15]; //
			put_ethernet_packet(
				tx_packet, 
				64,
				packet[11],
				packet[12],
				packet[13],
				0x0806);
		}
		return 0;
	}
	return number_of_bytes;
}

unsigned arp_ip_hi[16];
unsigned arp_ip_lo[16];
unsigned arp_mac_0[16];
unsigned arp_mac_1[16];
unsigned arp_mac_2[16];
unsigned arp_pounsigneder = 0;

//return the location of the ip address in the arp cache table
unsigned get_arp_cache(unsigned ip_hi, unsigned ip_lo){

        unsigned number_of_bytes;
	unsigned byte;
	unsigned packet[16];
	unsigned i;

	//Is the requested IP in the ARP cache?
	for(i=0; i<16; i++){
		if(arp_ip_hi[i] == ip_hi && arp_ip_lo[i] == ip_lo){
			return i;
		}
	}

        //It is not, so send an arp request
	tx_packet[7] = 0x0001u; //HTYPE ethernet
	tx_packet[8] = 0x0800u; //PTYPE IPV4
	tx_packet[9] = 0x0604u; //HLEN, PLEN
	tx_packet[10] = 0x0001u; //OPER=REQUEST
	tx_packet[11] = local_mac_address_hi; //SENDER_HARDWARE_ADDRESS
	tx_packet[12] = local_mac_address_med; //SENDER_HARDWARE_ADDRESS
	tx_packet[13] = local_mac_address_lo; //SENDER_HARDWARE_ADDRESS
	tx_packet[14] = local_ip_address_hi; //SENDER_PROTOCOL_ADDRESS
	tx_packet[15] = local_ip_address_lo; //SENDER_PROTOCOL_ADDRESS
	tx_packet[19] = ip_hi; //TARGET_PROTOCOL_ADDRESS
	tx_packet[20] = ip_lo; //
	put_ethernet_packet(
		tx_packet, 
		64u,
		0xffffu, //broadcast via ethernet
		0xffffu,
		0xffffu,
		0x0806u);

        //wait for a response
	while(1){

		number_of_bytes = get_eth();
		i = 0;
		for(byte=0; byte<number_of_bytes; byte+=2){
			//only keep the part of the packet we care about
			if(i < 16){
				packet[i] = get_eth();
			} else {
				get_eth();
			}
			i++;
		}

                //Process ARP requests within the data link layer
	        if (packet[6] == 0x0806 && packet[10] == 0x0002){
			if (packet[14] == ip_hi && packet[15] == ip_lo){
				arp_ip_hi[arp_pounsigneder] = ip_hi;
				arp_ip_lo[arp_pounsigneder] = ip_lo;
				arp_mac_0[arp_pounsigneder] = packet[11];
				arp_mac_1[arp_pounsigneder] = packet[12];
				arp_mac_2[arp_pounsigneder] = packet[13];
				i = arp_pounsigneder;
				arp_pounsigneder++;
				if(arp_pounsigneder == 16) arp_pounsigneder = 0;
				return i;
			}
		}
	}
}

////////////////////////////////////////////////////////////////////////////////
// Network Layer - Internet Protocol
//

void put_ip_packet(unsigned packet[], unsigned total_length, unsigned protocol, unsigned ip_hi, unsigned ip_lo){
	unsigned number_of_bytes, i, arp_cache;

	//see if the requested IP address is in the arp cache
	arp_cache = get_arp_cache(ip_hi, ip_lo);

        //Form IP header
	packet[7] = 0x4500;              //Version 4 header length 5x32
	packet[8] = total_length;        //IP data + header
	packet[9] = 0x0000;              //Identification
	packet[10] = 0x4000;             //don't fragment
	packet[11] = 0xFF00u | protocol;  //ttl|protocol
	packet[12] = 0x0000;             //checksum
	packet[13] = local_ip_address_hi;//source_high
	packet[14] = local_ip_address_lo;//source_low
	packet[15] = ip_hi;              //dest_high
	packet[16] = ip_lo;              //dest_low
	number_of_bytes = total_length + 14;

	//calculate checksum
        reset_checksum();
	for(i=7; i<=16; i++){
		add_checksum(packet[i]);
	}
	packet[12] = check_checksum();

	//enforce minimum ethernet frame size
	if(number_of_bytes < 64){
		number_of_bytes = 64;
	}

	//send packet over ethernet
	put_ethernet_packet(
		packet,                  //packet
		number_of_bytes,         //number_of_bytes
	       	arp_mac_0[arp_cache],    //destination mac address
		arp_mac_1[arp_cache],    //
		arp_mac_2[arp_cache],    //
		0x0800);                 //protocol IPv4
}

unsigned get_ip_packet(unsigned packet[]){
	unsigned ip_payload;
	unsigned total_length;
	unsigned header_length;
	unsigned payload_start;
	unsigned payload_length;
	unsigned i, from, to;
	unsigned payload_end;
	unsigned number_of_bytes;

	number_of_bytes = get_ethernet_packet(packet);

	if(number_of_bytes == 0) return 0;
	if(packet[6] != 0x0800) return 0;
	if(packet[15] != local_ip_address_hi) return 0;
	if(packet[16] != local_ip_address_lo) return 0;
	if((packet[11] & 0xff) == 1){//ICMP
		header_length = ((packet[7] >> 8) & 0xf) << 1;                   //in words
		payload_start = header_length + 7;                               //in words
		total_length = packet[8];                                        //in bytes
		payload_length = ((total_length+1) >> 1) - header_length;        //in words
		payload_end = payload_start + payload_length - 1;                //in words

		if(packet[payload_start] == 0x0800){//ping request

			//copy icmp packet to response
			to = 19;//assume that 17 and 18 are 0
			reset_checksum();
			for(from=payload_start+2; from<=payload_end; from++){
				i = packet[from];
				add_checksum(i);
				tx_packet[to] = i;
				to++;
			}
			tx_packet[17] = 0;//ping response
			tx_packet[18] = check_checksum();

			//send ping response
			put_ip_packet(
				tx_packet,
				total_length,
				1,//icmp
				packet[13], //remote ip
				packet[14]  //remote ip
			);
		}
		return 0;
				
	}
	if((packet[11] & 0xff) != 6) return 0;//TCP
	return number_of_bytes;
}

////////////////////////////////////////////////////////////////////////////////
// Transport Layer - TCP
//

unsigned remote_ip_hi, remote_ip_lo;

unsigned tx_source=0;
unsigned tx_dest=0;
unsigned tx_seq=0;
unsigned next_tx_seq=0;
unsigned tx_ack=0;
//const unsigned tx_window=1460; //ethernet MTU - 40 bytes for TCP/IP header
const unsigned tx_window=1024; //ethernet MTU - 40 bytes for TCP/IP header
const unsigned buffer_size = 1024;

unsigned tx_fin_flag=0;
unsigned tx_syn_flag=0;
unsigned tx_rst_flag=0;
unsigned tx_psh_flag=0;
unsigned tx_ack_flag=0;
unsigned tx_urg_flag=0;

unsigned rx_source=0;
unsigned rx_dest=0;
unsigned rx_seq=0;
unsigned rx_ack=0;
unsigned rx_window=0;

unsigned rx_fin_flag=0;
unsigned rx_syn_flag=0;
unsigned rx_rst_flag=0;
unsigned rx_psh_flag=0;
unsigned rx_ack_flag=0;
unsigned rx_urg_flag=0;

void put_tcp_packet(unsigned tx_packet [], unsigned tx_length){

    unsigned payload_start = 17;
	unsigned packet_length;
	unsigned index;
	unsigned i;

	//encode TCP header
	tx_packet[payload_start + 0] = tx_source;
	tx_packet[payload_start + 1] = tx_dest;
	tx_packet[payload_start + 2] = tx_seq >> 16;
	tx_packet[payload_start + 3] = tx_seq & 0xffff;
	tx_packet[payload_start + 4] = tx_ack >> 16;
	tx_packet[payload_start + 5] = tx_ack & 0xffff;
	tx_packet[payload_start + 6] = 0x5000; //5 long words
	tx_packet[payload_start + 7] = tx_window;
	tx_packet[payload_start + 8] = 0;
	tx_packet[payload_start + 9] = 0;

	//encode flags
	if(tx_fin_flag) tx_packet[payload_start + 6] |= 0x01;
	if(tx_syn_flag) tx_packet[payload_start + 6] |= 0x02;
	if(tx_rst_flag) tx_packet[payload_start + 6] |= 0x04;
	if(tx_psh_flag) tx_packet[payload_start + 6] |= 0x08;
	if(tx_ack_flag) tx_packet[payload_start + 6] |= 0x10;
	if(tx_urg_flag) tx_packet[payload_start + 6] |= 0x20;

	//calculate checksum
	//length of payload + header + pseudo_header in words
        reset_checksum();
        add_checksum(local_ip_address_hi);
        add_checksum(local_ip_address_lo);
        add_checksum(remote_ip_hi);
        add_checksum(remote_ip_lo);
        add_checksum(0x0006);
        add_checksum(tx_length+20);//tcp_header + tcp_payload in bytes

	packet_length = (tx_length + 20 + 1) >> 1; 
	index = payload_start;
	for(i=0; i<packet_length; i++){
		add_checksum(tx_packet[index]);
		index++;
	}
	tx_packet[payload_start + 8] = check_checksum();

	put_ip_packet(
		tx_packet,
		tx_length + 40,
		6,//tcp
		remote_ip_hi, //remote ip
		remote_ip_lo  //remote ip
	);
}

unsigned rx_length, rx_start;

unsigned get_tcp_packet(unsigned rx_packet []){

    unsigned number_of_bytes, header_length, payload_start, total_length, payload_length, payload_end, tcp_header_length;

	number_of_bytes = get_ip_packet(rx_packet);

	//decode lengths from the IP header
	header_length = ((rx_packet[7] >> 8) & 0xf) << 1;                   //in words
	payload_start = header_length + 7;                                  //in words

	total_length = rx_packet[8];                                        //in bytes
	payload_length = total_length - (header_length << 1);               //in bytes
	tcp_header_length = ((rx_packet[payload_start + 6] & 0xf000u)>>10); //in bytes
	rx_length = payload_length - tcp_header_length;                     //in bytes
	rx_start = payload_start + (tcp_header_length >> 1);                //in words

	//decode TCP header
	rx_source = rx_packet[payload_start + 0];
	rx_dest   = rx_packet[payload_start + 1];
	rx_seq    = rx_packet[payload_start + 2] << 16;
	rx_seq   |= rx_packet[payload_start + 3];
	rx_ack    = rx_packet[payload_start + 4] << 16;
	rx_ack   |= rx_packet[payload_start + 5];
	rx_window = rx_packet[payload_start + 7];

	//decode flags
	rx_fin_flag = rx_packet[payload_start + 6] & 0x01;
	rx_syn_flag = rx_packet[payload_start + 6] & 0x02;
	rx_rst_flag = rx_packet[payload_start + 6] & 0x04;
	rx_psh_flag = rx_packet[payload_start + 6] & 0x08;
	rx_ack_flag = rx_packet[payload_start + 6] & 0x10;
	rx_urg_flag = rx_packet[payload_start + 6] & 0x20;

	return number_of_bytes;
}

unsigned rx_buffer[buffer_size];
unsigned tx_buffer[buffer_size];
unsigned rx_i=0, rx_o=0, tx_i=0, tx_o=0, rx_fill=0, tx_fill=0;

void application_acknowledge_data(unsigned length){
    tx_o += length;
    if (tx_o > buffer_size) tx_o -= buffer_size;
    tx_fill -= length;
}

unsigned application_get_data(unsigned packet[], unsigned start){
	unsigned length = 0;
    unsigned packet_upper = 1;
    unsigned byte, i=0;
    //remember where we started, incase we need to resend
    unsigned tx_o_copy = tx_o;
    unsigned tx_fill_copy = tx_fill;

	while(tx_fill_copy){
        if(packet_upper){
            packet_upper = 0;
            packet[start+i] = tx_buffer[tx_o_copy++] << 8;
        } else {
            packet_upper = 1;
            packet[start+i] |= tx_buffer[tx_o_copy++] & 0xff;
            i++;
        }
        if(tx_o_copy == buffer_size) tx_o_copy = 0;
        length++; tx_fill_copy--;
	}
	return length;
}

unsigned application_put_data(unsigned packet[], unsigned start, unsigned length){
    unsigned packet_upper = 1;
    unsigned space_left_bytes;
    unsigned byte, i=0;

    //check that there is enough space to acxcept the packet
    space_left_bytes = buffer_size - rx_fill;
    if( space_left_bytes < length ) return 0;

    //copy packet data into receive buffer
	while(length){
        if(packet_upper){
            packet_upper = 0;
            byte = packet[start+i] >> 8;
        } else {
            packet_upper = 1;
            byte = packet[start+i] & 0xff;
            i++;
        }
        rx_buffer[rx_i++] = byte;
        if(rx_i == buffer_size) rx_i = 0;
        rx_fill++;
        length--;
	}
    return 1;
}


void do_data_exchange(){

    while( (output_ready(output_socket) && rx_fill) ||
           (ready(input_socket) && tx_fill <= buffer_size) ){

        if(output_ready(output_socket) && rx_fill){
            fputc(rx_buffer[rx_o++], output_socket);
            rx_fill--;
            if(rx_o == buffer_size) rx_o = 0;
        }

        if(ready(input_socket) && tx_fill <= buffer_size){
            tx_buffer[tx_i++] = fgetc(input_socket);
            tx_fill++;
            if(tx_i == buffer_size) tx_i = 0;
        }

    }

}

void server()
{
	unsigned rx_packet[1024];
	unsigned tx_packet[1024];
	unsigned tx_start = 27;

	unsigned tx_length;
	unsigned timeout;
	unsigned bytes;
    unsigned retries;
    unsigned RTO;
    unsigned KEEP_ALIVE;

	tx_seq = 0;

    stdout = rs232_tx;

    while(1){

       //LISTEN
       ////////
       puts("LISTEN\n");
       tx_rst_flag = 0;
       tx_syn_flag = 0;
       tx_fin_flag = 0;
       tx_ack_flag = 0;
       tx_psh_flag = 0;
       while(1){
           bytes = get_tcp_packet(rx_packet);
           if( bytes && 
               rx_dest == local_port &&
               rx_syn_flag)
           {
               break;
           }
       }

       //SYN RECVD
       ///////////
       puts("SYN RECEIVED\n");

       //set remote ip/port
       remote_ip_hi = rx_packet[13];
       remote_ip_lo = rx_packet[14];
       tx_dest = rx_source;
       tx_source = local_port;

       tx_ack = rx_seq + 1;
       tx_syn_flag = 1;
       tx_ack_flag = 1;

       // keep sending syn ack until we see an ack
       timeout = 10000; //~1second
       retries = 0;
       while(1){
           // send syn_ack
           if (!retries--){
               put_tcp_packet(tx_packet, 0);
               retries = 10;
               if( !timeout-- ) break;
           }
           bytes = get_tcp_packet(rx_packet);
           if( bytes && 
               rx_dest == local_port &&
               rx_source == tx_dest &&
               rx_ack_flag)
           {
               break;
           }
       }

       if(!timeout){
           tx_syn_flag = 0;
           tx_fin_flag = 0;
           tx_ack_flag = 0;
           tx_rst_flag = 1;
           put_tcp_packet(tx_packet, 0);
           continue;
       }

       //ESTABLISHED
       /////////////
       puts("ESTABLISHED\n");
       tx_seq = rx_ack;
       tx_syn_flag = 0;
       tx_ack_flag = 1;
       tx_psh_flag = 1;

       while(1){

           do_data_exchange();

           //transmit
           if (rx_ack == tx_seq) {
               tx_length = application_get_data(tx_packet, tx_start);
               if(tx_length){
                 put_tcp_packet(tx_packet, tx_length);
               }
               RTO = 10000;

           //retransmit
           } else {
               if(!RTO--){
                   //see if there is any other data to send this time
                   tx_length = application_get_data(tx_packet, tx_start);
                   put_tcp_packet(tx_packet, tx_length);
                   RTO = 10000;
               }
           }

           //get some data
           if( get_tcp_packet(rx_packet) && 
               rx_dest == local_port && 
               rx_source == tx_dest)
           {
                //if this is the next segment
                if( rx_seq == tx_ack ) {
                    //and we have enough space to accept it
                    if(application_put_data(rx_packet, rx_start, rx_length)){
                       //acknowledge the data
                       tx_ack = rx_seq + rx_length;
                       put_tcp_packet(tx_packet, 0);
                    }
                }
                if( rx_ack_flag )
                {
                    //realease data thats been stored up in case a retransmit is needed
                    application_acknowledge_data(rx_ack - tx_seq);
                    //send data starting from last acknowledge
                    tx_seq = rx_ack;
                }
                if(rx_fin_flag) break;
           }
       }

       if(!timeout){
           tx_psh_flag = 0;
           tx_syn_flag = 0;
           tx_fin_flag = 0;
           tx_ack_flag = 1;
           tx_rst_flag = 1;
           put_tcp_packet(tx_packet, 0);
           continue;
       }

       //WAIT CLOSE
       ////////////
       puts("WAIT CLOSE\n");
       tx_psh_flag = 0;
       tx_fin_flag = 1;
       tx_ack_flag = 1;
       tx_ack = rx_seq + 1;

       timeout = 10000;
       retries = 0;
       while(1){
            // send syn_ack
            if (!retries--){
                put_tcp_packet(tx_packet, 0);
                retries = 10;
                if( !timeout-- ) break;
            }
            bytes = get_tcp_packet(rx_packet);
            if( bytes && 
                rx_dest == local_port && 
                rx_source == tx_dest &&
                rx_ack_flag )
            {
                break;
            }
            if( !timeout-- ) break;
            wait_clocks(5000);
       }

       if(!timeout){
            tx_syn_flag = 0;
            tx_fin_flag = 0;
            tx_ack_flag = 0;
            tx_rst_flag = 1;
            put_tcp_packet(tx_packet, 0);
            continue;
       }
   }
}

