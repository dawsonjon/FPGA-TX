#include "server.h"
#include <stdio.h>
#include <print.h>

unsigned tcp_in = input("tcp_in");
unsigned tcp_out = output("tcp_out");
unsigned application_in = input("application_in");

void tcp_tx(){

    unsigned resend, last_state, state, ip_from , ip_to, tx_source, tx_dest,
    tx_ack, rx_ack, tx_flags, tx_seq, payload_length, payload_words, checksum ,
    remote_ip_address_hi, remote_ip_address_lo, length, tx_window, urgent, i, high_byte;

    unsigned packet[HALF_MTU];

    stdout = output("cout");


    resend = resendcount;
    while(1){

        /* get control words */
        last_state = state;
        state = fgetc(tcp_in);
        ip_from = fgetc(tcp_in);
        ip_to = fgetc(tcp_in);
        tx_source = fgetc(tcp_in);
        tx_dest = fgetc(tcp_in);
        tx_ack = fgetc(tcp_in);
        rx_ack = fgetc(tcp_in);
        tx_flags = fgetc(tcp_in);

        /*if something hapened send packet now instead of next interval*/
        if(state != last_state) resend = 0;

        if(state == established && last_state == syn_seen){
            tx_seq = tx_ack;
        }

        /*get data from application (if we are connected)*/
        if (state == established) {
            if(tx_ack == tx_seq + payload_length){
                tx_seq = tx_ack;
                payload_length = 0;
                payload_words = 0;
            }

            while(payload_length < MTU){
                /*immediately send data rather than waiting for next resend*/
                resend = 0;
                high_byte = fgetc(application_in) << 8;
                packet[payload_words++] = high_byte | fgetc(application_in);
                payload_length += 2;
                if(!ready(application_in)){
                    wait_clocks(100);
                    if(!ready(application_in)) break;
                }
            }
        }

        if(state != listen && resend-- == 0){

            resend = resendcount;
            /*calculate checksum*/
            remote_ip_address_hi = ip_to >> 16;
            remote_ip_address_lo = ip_to & 0xffff;
            tx_window = 1460;
            urgent = 0;
            checksum = local_ip_address_hi + local_ip_address_lo + remote_ip_address_hi + 
            remote_ip_address_lo + 6 + 20 + payload_length + tx_source + tx_dest + tx_seq + 
            rx_ack + (tx_flags | 0x5000) + tx_window + urgent;

            for(i=0; i<payload_words; i++) checksum += packet[i];
            checksum = (checksum >> 16) + (checksum & 0xffff);
            checksum += (checksum >> 16);
            checksum = ~checksum & 0xffff;

            /*send control words*/
            fputc(payload_length+20,  tcp_out);
            fputc(ip_from,   tcp_out);
            fputc(ip_to, tcp_out);

            /*encode TCP header*/
            fputc(tx_source, tcp_out);
            fputc(tx_dest, tcp_out);
            fputc(tx_seq >> 16, tcp_out);
            fputc(tx_seq & 0xffff, tcp_out);
            fputc(rx_ack >> 16, tcp_out);
            fputc(rx_ack & 0xffff, tcp_out);
            fputc(0x5000 | tx_flags, tcp_out);
            fputc(tx_window, tcp_out);
            fputc(checksum, tcp_out);
            fputc(urgent, tcp_out);

            /*Send Payload*/
            for(i=0; i<payload_words; i++) fputc(packet[i], tcp_out);
        }
    }
}
