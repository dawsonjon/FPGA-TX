#include "server.h"

unsigned tcp_in = input("tcp_in");
unsigned tcp_out = output("tcp_out");

void decouple(){

    unsigned state = listen;
    unsigned ip_from = 0;
    unsigned ip_to = 0;
    unsigned tx_source = 0;
    unsigned tx_dest = 0;
    unsigned tx_ack = 0;
    unsigned rx_ack = 0;
    unsigned tx_flags = 0;

    while(1){
        if(ready(tcp_in)){
            state = fgetc(tcp_in);
            ip_from = fgetc(tcp_in);
            ip_to = fgetc(tcp_in);
            tx_source = fgetc(tcp_in);
            tx_dest = fgetc(tcp_in);
            tx_ack = fgetc(tcp_in);
            rx_ack = fgetc(tcp_in);
            tx_flags = fgetc(tcp_in);
        }
        if(output_ready(tcp_out)){
            fputc(state, tcp_out);
            fputc(ip_from, tcp_out);
            fputc(ip_to, tcp_out);
            fputc(tx_source, tcp_out);
            fputc(tx_dest, tcp_out);
            fputc(tx_ack, tcp_out);
            fputc(rx_ack, tcp_out);
            fputc(tx_flags, tcp_out);
        }
    }
}
