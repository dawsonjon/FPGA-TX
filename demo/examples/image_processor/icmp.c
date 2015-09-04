////////////////////////////////////////////////////////////////////////////////
//
//  CHIPS-2.0 TCP/IP SERVER
//
//  :Author: Jonathan P Dawson
//  :Date: 17/10/2013
//  :email: chips@jondawson.org.uk
//  :license: MIT
//  :Copyright: Copyright (C) Jonathan P Dawson 2015
//
//  Respond to ICMP echo request (ping) packets.
//
////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>

unsigned icmp_in = input("icmp_in");
unsigned icmp_out = output("icmp_out");

void icmp(){

    /* save space for 1500 bytes MTU */
    unsigned packet[750];
    unsigned i, length, payload_words, ip_from, ip_to, type_code,
        checksum, header_0, header_1;

    stdout = output("cout");

    while(1){

        /* control words */
        length  = fgetc(icmp_in);
        payload_words = ((length -8 + 1) >> 1);
        ip_from = fgetc(icmp_in);
        ip_to   = fgetc(icmp_in);

        /* read header */
        type_code = fgetc(icmp_in);
        checksum = fgetc(icmp_in);
        header_0 = fgetc(icmp_in);
        header_1 = fgetc(icmp_in);

        /* respond to echo requests */
        if(type_code == 0x0800){ //echo request

            /* store packet */
            for(i=0; i<payload_words; i++){
                packet[i] = fgetc(icmp_in);
            }

            /* calculate checksum */
            checksum = 0;
            for(i=0; i<payload_words; i++){
                checksum += packet[i];
            }
            checksum = (checksum & 0xffff) + (checksum >> 16);
            checksum += (checksum >> 16);
            checksum = ~checksum & 0xffff;


            puts("icmp sending reply\n");
            /* send control words */
            /* swap from and to*/
            fputc(length,  icmp_out);
            fputc(ip_to,   icmp_out);
            fputc(ip_from, icmp_out);

            /* send header */
            type_code = 0; //reply
            fputc(type_code,  icmp_out);
            fputc(checksum,   icmp_out);
            fputc(header_0, icmp_out);
            fputc(header_1, icmp_out);

            /* send data */
            for(i=0; i<payload_words; i++){
                fputc(packet[i], icmp_out);
            }
            puts("icmp packet sent\n");

        } else {

            /* discard data */
            for(i=0; i<payload_words; i++){
                fgetc(icmp_in);
            }

        }
    }
}
