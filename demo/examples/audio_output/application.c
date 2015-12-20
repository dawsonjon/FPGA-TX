
unsigned audio_out = output("audio_out");
unsigned eth_out = output("eth_out");
unsigned eth_in = input("eth_in");
#include "ethernet.h"

void main(){
    unsigned t, length;
    unsigned buffer[256];

    wait_clocks(50000000);

    while(1){
        length = ethernet_get_data(buffer);
        ethernet_put_data(buffer, length);
        for(t=0; t<length>>1; t++){
            fputc(buffer[t], audio_out);
        }
    }
}
