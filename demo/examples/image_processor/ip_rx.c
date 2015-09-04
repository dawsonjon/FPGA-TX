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

#include "server.h"
#include <stdio.h>

unsigned arp = output("arp");
unsigned icmp_out = output("icmp_out");
unsigned ethernet_in = input("ethernet_in");

void discard(unsigned words){
    unsigned i;
    for(i=0; i<words; i++) fgetc(ethernet_in);
}


unsigned get_ethernet_header(){

    unsigned total_length, mac_from_0, mac_from_1, mac_from_2, mac_to_0, mac_to_1,
    mac_to_2, payload_words, i, payload_length, type;

    while(1){ 
        
        total_length = fgetc(ethernet_in); 
        payload_length = total_length - 14; 
        mac_to_0 = fgetc(ethernet_in);
        mac_to_1 = fgetc(ethernet_in);
        mac_to_2 = fgetc(ethernet_in); 
        mac_from_0 = fgetc(ethernet_in);
        mac_from_1 = fgetc(ethernet_in);
        mac_from_2 = fgetc(ethernet_in); 
        type = fgetc(ethernet_in); 
        payload_words = (total_length - 14 + 1) >> 1;


        if ((mac_to_0 == local_mac_address_hi && 
             mac_to_1 == local_mac_address_med && 
             mac_to_2 == local_mac_address_lo) ||
            (mac_to_0 == 0xffffu && 
             mac_to_1 == 0xffffu && 
             mac_to_2 == 0xffffu)){

            if(type == 0x0806){//arp 
                puts("Incoming ARP\n");
                fputc(payload_length, arp); 
                for(i=0; i<payload_words; i++){
                   fputc(fgetc(ethernet_in), arp); 
                }
            } else if(type == 0x0800){//ipv4
                puts("Incoming IPv4\n");
                return payload_length;
            } else {
                puts("Discard incoming unknown protocol\n");
                discard(payload_words);
            }

        } else {
            puts("IP not ours\n");
            discard(payload_words);
        }
    }
}

void ip_rx(){

    unsigned total_length, version, packet_length, identification, fragment,
    ttl_protocol, checksum, ip_from_hi, ip_from_lo, ip_to_hi, ip_to_lo,
    payload_words, payload_length, padding_words, ip_to, ip_from, i;

    stdout = output("cout");
    while(1){

        total_length = get_ethernet_header();
        version = fgetc(ethernet_in);
        packet_length = fgetc(ethernet_in); //length
        identification = fgetc(ethernet_in);
        fragment = fgetc(ethernet_in);
        ttl_protocol = fgetc(ethernet_in);
        checksum = fgetc(ethernet_in);
        ip_from_hi = fgetc(ethernet_in);
        ip_from_lo = fgetc(ethernet_in);
        ip_to_hi = fgetc(ethernet_in);
        ip_to_lo = fgetc(ethernet_in);

        payload_words = (packet_length - 20 + 1) >> 1;
        payload_length = packet_length - 20;
        padding_words = (total_length - packet_length) >> 1;

        if(ip_to_hi == local_ip_address_hi &&
           ip_to_lo == local_ip_address_lo){

            //if(ttl_protocol & 0xf == 1){//icmp
            if(1){//icmp
                puts("   is ICMP\n");

                if(output_ready(icmp_out)){
                    puts("   icmp ready, processing\n");
                    fputc(payload_length, icmp_out);
                    ip_from = (ip_from_hi << 16) | ip_from_lo;
                    fputc(ip_from, icmp_out);
                    ip_to = (ip_to_hi << 16) | ip_to_lo;
                    fputc(ip_to, icmp_out);
                    for(i=0; i<payload_words; i++) fputc(fgetc(ethernet_in), icmp_out);
                } else {
                    puts("   icmp not ready, discarding\n");
                    discard(payload_words);
                }

                discard(padding_words);
            } else {
                puts("   unknown protocol, discarding\n");
                discard(payload_words);
                discard(padding_words);
            }

        } else {
            puts("   not our IP, discarding\n");
            discard(payload_words);
            discard(padding_words);
        }
    }
}

