const unsigned mac_hi = 0x0001;
const unsigned mac_med = 0x0203;
const unsigned mac_lo = 0x0405;

unsigned source_hi, source_med, source_lo;

unsigned ethernet_get_data(unsigned data[]){

    unsigned payload_words, payload_length, length, i, dest_hi, dest_med, 
         dest_lo, protocol;

    while(1){
        length = fgetc(eth_in);
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

            i=0;
            while(payload_words){
                data[i++] = fgetc(eth_in);
                payload_words--;
            }
            return payload_length;

        } else {

            while(payload_words){
                fgetc(eth_in);
                payload_words--;
            }

        }
    }

}

void ethernet_put_data(unsigned data[], unsigned payload_length){

    unsigned length, i, payload_words;

    payload_words = (payload_length + 1) >> 1;
    length = payload_length + 14;

    fputc(length, eth_out);
    fputc(source_hi, eth_out);
    fputc(source_med, eth_out);
    fputc(source_lo,eth_out);
    fputc(mac_hi, eth_out);
    fputc(mac_med, eth_out);
    fputc(mac_lo, eth_out);
    fputc(payload_length, eth_out);

    i=0;
    while(payload_words){
        fputc(data[i++], eth_out);
        payload_words--;
    }

}
