from demo.components.server import server
from chips.api.api import *

def application(chip):

    eth = Component("""
    #include <stdio.h>
    #include <print.h>

    unsigned eth_out = output("eth_out");
    unsigned rs232_out = output("rs232_out");
    unsigned eth_in = input("eth_in");

    void main(){
        const unsigned mac_hi = 0x0001;
        const unsigned mac_med = 0x0203;
        const unsigned mac_lo = 0x0405;
        unsigned payload_words, payload_length, length, 
        dest_hi, dest_med, dest_lo, source_hi, source_med, source_lo, protocol;

        stdout = rs232_out;
        puts("raw ethernet echo\n");

        while(1){

            length = fgetc(eth_in);
            /*fprint_uhex(length, stdout); puts("\n");*/

            dest_hi = fgetc(eth_in);
            dest_med = fgetc(eth_in);
            dest_lo = fgetc(eth_in);
            source_hi = fgetc(eth_in);
            source_med = fgetc(eth_in);
            source_lo = fgetc(eth_in);
            protocol = fgetc(eth_in);

            payload_length = length - 14;
            payload_words = (payload_length + 1) >> 1;

            if(dest_hi == mac_hi && dest_med == mac_med && dest_lo == mac_lo){
                fputc(length, eth_out);
                fputc(source_hi, eth_out);
                fputc(source_med, eth_out);
                fputc(source_lo,eth_out);
                fputc(mac_hi, eth_out);
                fputc(mac_med, eth_out);
                fputc(mac_lo, eth_out);
                fputc(protocol, eth_out);

                /*echo*/
                while(payload_words){
                    fputc(fgetc(eth_in), eth_out);
                    payload_words--;
                }

            } else {

                /*ignore*/
                puts("ignore\n");
                while(payload_words){
                    fgetc(eth_in);
                    payload_words--;
                }

            }
        }

    }
    """, inline=True)

    eth(
        chip, 
        inputs = {
            "eth_in" : chip.inputs["input_eth_rx"],
        },
        outputs = {
            "eth_out" : chip.outputs["output_eth_tx"],
            "rs232_out" : chip.outputs["output_rs232_tx"],
        },
    )
