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

unsigned tcp_in = input("tcp_in");
unsigned tcp_out = output("tcp_out");
unsigned application_out = output("application_out");

void tcp_rx(){

    unsigned length, payload_bytes, payload_words, ip_from, ip_to, checksum,
    urgent_pointer, tcp_header_length, options_words, i, rx_source, rx_dest,
    rx_seq, rx_ack, rx_flags, rx_window, rx_fin_flag, rx_syn_flag, rx_rst_flag,
    rx_psh_flag, rx_ack_flag, rx_urg_flag, tx_source, tx_dest, tx_ack,
    tx_flags, tx_fin_flag, tx_syn_flag, tx_rst_flag, tx_ack_flag, tx_psh_flag,
    tx_urg_flag, timeout, state, word;

    stdout = output("cout");

    while(1){

        if(!ready(tcp_in)){
            if(!timeout-- && state != listen){
                puts("timed out\n");
                state = listen;
                tx_psh_flag = 0;
                tx_syn_flag = 0;
                tx_fin_flag = 0;
                tx_ack_flag = 1;
                tx_rst_flag = 1;
            }
            wait_clocks(100); //1 us;
            continue;
        }

  
        /* control words */
        length  = fgetc(tcp_in);
        payload_bytes = length - 20;
        payload_words = ((payload_bytes + 1) >> 1);
        ip_from = fgetc(tcp_in);
        ip_to   = fgetc(tcp_in);

        /*decode TCP header*/
        rx_source = fgetc(tcp_in);
        rx_dest   = fgetc(tcp_in);
        rx_seq    = fgetc(tcp_in) << 16;
        rx_seq   |= fgetc(tcp_in);
        tx_ack    = fgetc(tcp_in) << 16;
        tx_ack   |= fgetc(tcp_in);
        rx_flags  = fgetc(tcp_in);
        rx_window = fgetc(tcp_in);
        checksum  = fgetc(tcp_in);
        urgent_pointer = fgetc(tcp_in);

        /*calculate header length*/
        tcp_header_length = (rx_flags & 0xf000u)>>12; //long words
        options_words = (tcp_header_length - 5) << 1; //words
        payload_words -= options_words;
        payload_bytes -= (options_words << 1);
        for(i=0; i<options_words; i++){
            fgetc(tcp_in); //discard options
        }

        /*decode flags*/
        rx_fin_flag = rx_flags & 0x01;
        rx_syn_flag = rx_flags & 0x02;
        rx_rst_flag = rx_flags & 0x04;
        rx_psh_flag = rx_flags & 0x08;
        rx_ack_flag = rx_flags & 0x10;
        rx_urg_flag = rx_flags & 0x20;

        if(rx_dest != local_port){
             for(i=0; i<payload_words; i++) fgetc(tcp_in);
             break;
        }


        switch(state){

            case listen:

               tx_rst_flag = 0;
               tx_syn_flag = 0;
               tx_fin_flag = 0;
               tx_ack_flag = 0;
               tx_psh_flag = 0;

               if(rx_syn_flag){
                   puts("syn_seen\n");
                   timeout = maxtimeout;
                   state = syn_seen;
                   tx_source = local_port;
                   tx_dest = rx_source;
                   rx_ack = rx_seq + 1;
                   tx_syn_flag = 1;
                   tx_ack_flag = 1;
               }

               for(i=0; i<payload_words; i++) fgetc(tcp_in);
               break;

            case syn_seen:

               if(rx_ack_flag){
                   puts("connected\n");
                   timeout = maxtimeout;
                   state = established;
                   tx_syn_flag = 0;
               }

               for(i=0; i<payload_words; i++) fgetc(tcp_in);
               break;

            case established:

               if(rx_fin_flag){
                   timeout = maxtimeout;
                   state = wait_close;
                   tx_fin_flag = 1;
                   rx_ack = rx_seq + 1;
                   puts("closing\n");
               }

               if(rx_seq == rx_ack) {
                   timeout = maxtimeout;
                   for(i=0; i<payload_words; i++) {
                       word = fgetc(tcp_in);
                       fputc(word >> 8, application_out);
                       fputc(word & 0xff, application_out);
                   }
                   rx_ack = rx_seq + payload_bytes;
               } else {
                   for(i=0; i<payload_words; i++) fgetc(tcp_in);
               }
               break;

            case wait_close:

               if(rx_ack_flag) {
                   puts("closed\n");
                   timeout = maxtimeout;
                   state = listen;
                   tx_rst_flag = 0;
                   tx_syn_flag = 0;
                   tx_fin_flag = 0;
                   tx_ack_flag = 0;
                   tx_psh_flag = 0;
               }

               for(i=0; i<payload_words; i++) fgetc(tcp_in);
               break;

        }
        if(rx_rst_flag) {
            puts("connection reset by remote host\n");
            timeout = maxtimeout;
            state = listen;
            tx_rst_flag = 0;
            tx_syn_flag = 0;
            tx_fin_flag = 0;
            tx_ack_flag = 0;
            tx_psh_flag = 0;
        }

        tx_flags = 0;
        if(tx_fin_flag) tx_flags |= 0x01;
        if(tx_syn_flag) tx_flags |= 0x02;
        if(tx_rst_flag) tx_flags |= 0x04;
        if(tx_psh_flag) tx_flags |= 0x08;
        if(tx_ack_flag) tx_flags |= 0x10;
        if(tx_urg_flag) tx_flags |= 0x20;

        fputc(state, tcp_out);
        fputc(ip_to, tcp_out);
        fputc(ip_from, tcp_out);
        fputc(tx_source, tcp_out);
        fputc(tx_dest, tcp_out);
        fputc(tx_ack, tcp_out);
        fputc(rx_ack, tcp_out);
        fputc(tx_flags, tcp_out);

   }
}



