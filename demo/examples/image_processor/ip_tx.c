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
//  Administer the transmission side of the IP layer. Processes ARP requests.
//
////////////////////////////////////////////////////////////////////////////////

#include "server.h"
#include <stdio.h>

unsigned arp = input("arp");
unsigned icmp_in = input("icmp_in");
unsigned ethernet_out = output("ethernet_out");

void put_ethernet_header(
		unsigned payload_bytes,
	    unsigned destination_mac_address_hi,
		unsigned destination_mac_address_med,
		unsigned destination_mac_address_lo,
		unsigned protocol){

	fputc(payload_bytes + 14, ethernet_out);
	fputc(destination_mac_address_hi, ethernet_out);
	fputc(destination_mac_address_med, ethernet_out);
	fputc(destination_mac_address_lo, ethernet_out);
	fputc(local_mac_address_hi, ethernet_out);
	fputc(local_mac_address_med, ethernet_out);
	fputc(local_mac_address_lo, ethernet_out);
	fputc(protocol, ethernet_out);

}

unsigned arp_ip_hi[16];
unsigned arp_ip_lo[16];
unsigned arp_mac_0[16];
unsigned arp_mac_1[16];
unsigned arp_mac_2[16];
unsigned arp_pointer = 0;

/* process arp requests */
void process_arp_request(){

    unsigned number_of_bytes, htype, ptype, hlen_plen, oper, sender_mac_address_hi,
    sender_mac_address_med, sender_mac_address_lo, sender_ip_address_hi,
    sender_ip_address_lo, i, remaining_words;

    puts("tx: get arp request\n");
    number_of_bytes = fgetc(arp);
    htype = fgetc(arp);
    ptype = fgetc(arp);
    hlen_plen = fgetc(arp);
    oper = fgetc(arp);
    sender_mac_address_hi = fgetc(arp);  //SENDER_HARDWARE_ADDRESS
    sender_mac_address_med = fgetc(arp); //SENDER_HARDWARE_ADDRESS
    sender_mac_address_lo = fgetc(arp);  //SENDER_HARDWARE_ADDRESS
    sender_ip_address_hi = fgetc(arp);   //SENDER_PROTOCOL_ADDRESS
    sender_ip_address_lo = fgetc(arp);   //SENDER_PROTOCOL_ADDRESS

    /* discard the rest of the arp request */
    remaining_words = (number_of_bytes - 18 + 1) >> 1;
    for(i=0; i<remaining_words; i++) fgetc(arp);

    if (oper == 0x0001){ //request

        puts("tx: send arp response\n");

        htype = 0x0001u; //ETHERNET
        ptype = 0x0800u; //IPV4
        hlen_plen = 0x0604u;
        oper = 0x0002u; //OPER=REPLY
        
        put_ethernet_header(64, 0xffff, 0xffff, 0xffff, 0x0806);
        fputc(htype, ethernet_out);
        fputc(ptype, ethernet_out);
        fputc(hlen_plen, ethernet_out);
        fputc(oper, ethernet_out);
        fputc(local_mac_address_hi, ethernet_out);  //SENDER_HARDWARE_ADDRESS
        fputc(local_mac_address_med, ethernet_out); //SENDER_HARDWARE_ADDRESS
        fputc(local_mac_address_lo, ethernet_out);  //SENDER_HARDWARE_ADDRESS
        fputc(local_ip_address_hi, ethernet_out);   //SENDER_PROTOCOL_ADDRESS
        fputc(local_ip_address_lo, ethernet_out);   //SENDER_PROTOCOL_ADDRESS
        fputc(sender_ip_address_hi, ethernet_out);  //TARGET_PROTOCOL_ADDRESS
        fputc(sender_ip_address_lo, ethernet_out);  //

        /*send 20 bytes of padding to give 64 byte packet*/
        for(i=0; i<21; i++) fputc(0, ethernet_out);
    }

    /*store in arp cache*/
    arp_ip_hi[arp_pointer] = sender_ip_address_hi;
    arp_ip_lo[arp_pointer] = sender_ip_address_lo;
    arp_mac_0[arp_pointer] = sender_mac_address_hi;
    arp_mac_1[arp_pointer] = sender_mac_address_med;
    arp_mac_2[arp_pointer] = sender_mac_address_lo;
    i = arp_pointer;
    arp_pointer++;
    if(arp_pointer == 16) arp_pointer = 0;
}

/* return the location of the ip address in the arp cache table */
int get_arp_cache(unsigned ip_hi, unsigned ip_lo){

    unsigned number_of_bytes, htype, ptype, hlen_plen, oper, sender_mac_address_hi,
    sender_mac_address_med, sender_mac_address_lo, sender_ip_address_hi,
    sender_ip_address_lo, i, remaining_words;

    puts("tx looking up address\n");

	/* is the requested IP in the ARP cache? */
	for(i=0; i<16; i++){
		if(arp_ip_hi[i] == ip_hi && arp_ip_lo[i] == ip_lo){
            puts("  hit address in cache\n");
			return i;
		}
	}

    puts("tx miss address not in cache, request\n");
    /* it is not, so send an arp request */
	htype = 0x0001u; //ETHERNET
	ptype = 0x0800u; //IPV4
	hlen_plen = 0x0604u;
	oper = 0x0001u; //OPER=REQUEST
    
    put_ethernet_header(64, 0xffff, 0xffff, 0xffff, 0x0806);
    fputc(htype, ethernet_out);
    fputc(ptype, ethernet_out);
    fputc(hlen_plen, ethernet_out);
    fputc(oper, ethernet_out);
	fputc(local_mac_address_hi, ethernet_out);  //SENDER_HARDWARE_ADDRESS
	fputc(local_mac_address_med, ethernet_out); //SENDER_HARDWARE_ADDRESS
	fputc(local_mac_address_lo, ethernet_out);  //SENDER_HARDWARE_ADDRESS
	fputc(local_ip_address_hi, ethernet_out);   //SENDER_PROTOCOL_ADDRESS
	fputc(local_ip_address_lo, ethernet_out);   //SENDER_PROTOCOL_ADDRESS
    fputc(0, ethernet_out);
    fputc(0, ethernet_out);
    fputc(0, ethernet_out);
	fputc(ip_hi, ethernet_out);                 //TARGET_PROTOCOL_ADDRESS
	fputc(ip_lo, ethernet_out);                 //

    /*send 42 bytes of padding to give 64 byte packet*/
    for(i=0; i<18; i++) {
        fputc(0, ethernet_out);
    }

    return -1;

    /*wait for a reply*/
    /*    puts("tx  waiting for arp response\n");
		number_of_bytes = fgetc(arp);
        htype = fgetc(arp);
        ptype = fgetc(arp);
        hlen_plen = fgetc(arp);
        oper = fgetc(arp);
        sender_mac_address_hi = fgetc(arp);  //SENDER_HARDWARE_ADDRESS
        sender_mac_address_med = fgetc(arp); //SENDER_HARDWARE_ADDRESS
        sender_mac_address_lo = fgetc(arp);  //SENDER_HARDWARE_ADDRESS
        sender_ip_address_hi = fgetc(arp);   //SENDER_PROTOCOL_ADDRESS
        sender_ip_address_lo = fgetc(arp);   //SENDER_PROTOCOL_ADDRESS

        remaining_words = (number_of_bytes - 18 + 1) >> 1;
        for(i=0; i<remaining_words; i++) fgetc(arp);
        puts("tx  arp reponse seen\n");


        report(oper);
        report(sender_ip_address_hi);
        report(sender_ip_address_lo);
        report(ip_hi);
        report(ip_lo);
	    if (oper == 0x0002 && //reply
			sender_ip_address_hi == ip_hi && 
            sender_ip_address_lo == ip_lo){
            arp_ip_hi[arp_pointer] = ip_hi;
            arp_ip_lo[arp_pointer] = ip_lo;
            arp_mac_0[arp_pointer] = sender_mac_address_hi;
            arp_mac_1[arp_pointer] = sender_mac_address_med;
            arp_mac_2[arp_pointer] = sender_mac_address_lo;
            i = arp_pointer;
            arp_pointer++;
            if(arp_pointer == 16) arp_pointer = 0;
            return i;
            puts("tx  returning ip address\n");
		}
        puts("tx arp response not for us\n");*/
}

void send_ip_header(
    unsigned payload_length, 
    unsigned ip_to, 
    unsigned protocol){

    unsigned version, total_length, identification, fragment, ttl_protocol,
    checksum, ip_to_hi, ip_to_lo, l; 

    /*fill in header*/
	version = 0x4500;                    //Version 4 header length 5x32
	total_length = payload_length + 20;  //IP data + header
	identification = 0x0000;             //Identification
	fragment = 0x4000;                   //don't fragment
	ttl_protocol = 0xFF00u | protocol;   //ttl|protocol
	checksum = 0x0000;                   //checksum
	ip_to_hi = ip_to >> 16;              //dest_high
	ip_to_lo = ip_to & 0xffff;           //dest_low

	/*calculate checksum*/
    checksum = version + total_length + identification + fragment +
    ttl_protocol + checksum + local_ip_address_hi + local_ip_address_lo +
    ip_to_hi + ip_to_lo;
    checksum = (checksum >> 16) + checksum & 0xffff;
    checksum += (checksum >> 16);
    checksum = ~checksum & 0xffff;

	/* work out hardware address */
    l = get_arp_cache(ip_to_hi, ip_to_lo);
    puts("tx hrdware address obtained\n");
    put_ethernet_header(total_length, arp_mac_0[l], arp_mac_1[l], arp_mac_2[l], 0x0800);
    puts("tx sent ethernet header\n");

	/*send ip header*/
	fputc(version, ethernet_out);
	fputc(total_length, ethernet_out);
	fputc(identification, ethernet_out);
	fputc(fragment, ethernet_out);
	fputc(ttl_protocol, ethernet_out);
	fputc(checksum, ethernet_out);
	fputc(local_ip_address_hi, ethernet_out);
	fputc(local_ip_address_lo, ethernet_out);
	fputc(ip_to_hi, ethernet_out);
	fputc(ip_to_lo, ethernet_out);

}

void ip_rx(){
    unsigned length, payload_words, ip_from, ip_to, i, ip_to_hi, ip_to_lo;
    stdout = output("cout");
    while(1){
        if(ready(icmp_in)){
            puts("Sending ICMP response\n");

            /* read control words */
            length  = fgetc(icmp_in);
            payload_words = ((length + 1) >> 1);
            ip_from = fgetc(icmp_in);
            ip_to   = fgetc(icmp_in);
            ip_to_hi = ip_to >> 16;
            ip_to_lo = ip_to & 0xffff;

            /* send ip packet via ethernet */
            i = get_arp_cache(ip_to_hi, ip_to_lo);
            if(i < 0){
                /*if the ip is in not in out cache then discard it*/
                for(i=0; i<payload_words; i++){
                    fputc(fgetc(icmp_in), ethernet_out);
                }
            } else {
                send_ip_header(length, ip_to, 1);
                for(i=0; i<payload_words; i++){
                    fputc(fgetc(icmp_in), ethernet_out);
                }
            }


        }
        if(ready(arp)){
            puts("Processing ARP\n");
            process_arp_request();
        }
    }
}
