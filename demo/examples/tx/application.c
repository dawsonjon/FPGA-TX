
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

#define CLOCK_FREQUENCY 100.0e6
#define RF_SAMPLING_FREQUENCY 800.0e6
#define NO_FREQUENCY_STEPS 4294967296.0

void flush_stdin(){
    while(1){
        wait_clocks(50000000);
        while(ready(stdin)){
            fgetc(stdin);
            wait_clocks(10000000);
        }
        if(!ready(stdin)) return;
    }
}

void send_am(signed sample){
  sample >>= 1; //-64 <= sample <= 63
  sample += 64; //0 <= sample <= 127 
  sample |= sample << 16; //duplicate for i and q
  fputc(sample, am_out);
}

void send_iq(signed sample){
  fputc(sample, am_out);
}

void send_fm_12k(signed sample, unsigned frequency_steps){
  //-128 <= sample <= 127
  int frequency = frequency_steps + (sample * 252); //~+6KHz
  fputc(frequency, frequency_out);
}

void main(){

    unsigned frequency_hz = 27005000.0;
    double frequency_hz_double, frequency_steps_double;
    unsigned frequency_steps;
    unsigned ip, op, next_sample_time, length, count=3;
    int buffer[256];
    char cmd;

    stdout = rs232_tx;
    stdin = rs232_rx;
    flush_stdin();

    while(1){
        //implement command interface
        puts(">\n");
        cmd = getc();
        
        switch(cmd)
        {
            //set frequency
            case 'f':
                frequency_hz = scan_udecimal();
                frequency_hz_double = frequency_hz;
                frequency_steps_double = frequency_hz_double/(800.0e6/4294967296.0);
                frequency_steps = frequency_steps_double;
                print_udecimal(frequency_steps);
                puts("\n");
                fputc(frequency_steps, frequency_out);
                break;

            //mode a AM 1200
            case 'a':
                length = getc();
                //set frequency to carrier frequency
                fputc(frequency_steps, frequency_out);
                next_sample_time = timer_low() + 8333;
                op = 0;
                ip = 0;
                while(op<length){
                    if(ready(stdin)){
                        buffer[ip++] = getc()-128;
                    }
                    if(timer_low() >= next_sample_time){
                        //accept audio at ~12KHz 8 bit
                        //-128 <= sample <= 127
                        send_am(buffer[op++] >> 2);
                        next_sample_time += 8333;
                    }
                }
                break;

            //mode b FM 8-bit
            case 'b':
                length = getc();
                //set am to maximum
                fputc(0x007f007f, am_out);
                next_sample_time = timer_low() + 8333;
                op = 0;
                ip = 0;
                while(op<length){
                    if(ready(stdin)){
                        buffer[ip++] = getc()-128;
                    }
                    if(timer_low() >= next_sample_time){
                        //accept audio at ~12KHz 8 bit
                        //-128 <= sample <= 127
                        send_fm_12k(buffer[op++], frequency_steps);
                        next_sample_time += 8333;
                    }
                }
                break;

            //mode a IQ
            case 'c':
                length = getc();
                //set frequency to carrier frequency
                fputc(frequency_steps, frequency_out);
                next_sample_time = timer_low() + 8333;
                op = 0;
                ip = 0;
                while(op<length){
                    if(ready(stdin)){
                        buffer[ip++] = getc()-128 | ((getc()-128) << 16);
                    }
                    if(timer_low() >= next_sample_time){
                        //accept audio at ~12KHz 8 bit
                        //-128 <= sample <= 127
                        send_iq(buffer[op++]);
                        next_sample_time += 8333;
                    }
                }
                break;

            //echo
            case 'z':
                length = getc();
                op = 0;
                while(op<length){
                    putc(getc());
                    op++;
                }
                break;
        }
    }
}
