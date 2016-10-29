
unsigned eth_in = input("eth_in");
unsigned rs232_rx = input("rs232_rx");

unsigned eth_out = output("eth_out");
unsigned audio_out = output("audio_out");
unsigned frequency_out = output("freq_out");
unsigned am_out = output("am_out");
unsigned rs232_tx = output("rs232_tx");

#include "ethernet.h"
#include "scan.h"
#include "print.h"

#define RF_SAMPLING_FREQUENCY 800.0e6
#define NO_FREQUENCY_STEPS 4294967296.0


void send_am(signed sample){
  sample >>= 1; //-64 <= sample <= 63
  sample += 64; //0 <= sample <= 127 
  sample |= sample << 16; //duplicate for i and q
  fputc(sample, am_out);
}

void send_fm_12(signed sample, unsigned frequency_steps){
  //-128 <= sample <= 127
  int frequency = frequency_steps + (sample * 252);
  fputc(frequency, frequency_out);
  wait_clocks(8333);
}

void main(){

    unsigned frequency_hz = 27005000;
    double frequency_steps_double;
    unsigned frequency_steps;
    unsigned t, length, count=3;
    int sample;
    int buffer[256];

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("FPGA TX\n");
    puts("=======\n\n");
    puts("enter frequency in hz:\n");

    frequency_hz = scan_udecimal();
    frequency_steps_double = ((double)frequency_hz)/(RF_SAMPLING_FREQUENCY/NO_FREQUENCY_STEPS);
    frequency_steps = frequency_steps_double;
    print_udecimal(frequency_steps);
    puts("\n");
    fputc(frequency_steps, frequency_out);
    fputc(0x007f007f, am_out);
    puts("transmitting audio:\n");

    while(1){

      length = ethernet_get_data(buffer);
      ethernet_put_data(buffer, length);
      count = 3;

      for(t=0; t<length>>1; t++){
        //accept audio at ~48KHz
        //send average of 4 samples to give ~12KHz
        //0 <= sample <= 255
        sample += (buffer[t] & 0xff) - 128;
        if(!count--){
            //send_am(sample >> 2);
            send_fm_12(sample, frequency_steps);
            sample = 0;
            count = 3;
        }
      }

    }

}
