
unsigned rs232_rx = input("rs232_rx");

unsigned audio_out = output("audio_out");
unsigned frequency_out = output("freq_out");
unsigned am_out = output("am_out");
unsigned ctl_out = output("ctl_out");
unsigned rs232_tx = output("rs232_tx");

#include "scan.h"
#include "print.h"

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

void send_iq(signed i, signed q){
  int sample;
  sample = (i & 0xff) << 16;
  sample |= (q & 0xff);
  fputc(sample, am_out);
}

void send_fm(signed sample, unsigned frequency_steps, unsigned fm_deviation){
  //-128 <= sample <= 127
  int frequency;
  frequency = sample*fm_deviation;
  frequency >>= 8;
  frequency += frequency_steps;
  fputc(frequency, frequency_out);
}

void main(){

    unsigned frequency_steps = 0;
    unsigned sample_rate_steps = 8333; //default to 12k
    unsigned fm_deviation = 105; //default to 5kHz
    unsigned control = 0; //dithering off
    unsigned op, next_sample_time=0, length;
    unsigned next_multiple_of_8_samples;
    int sample, i, q;
    char cmd;

    stdout = rs232_tx;
    stdin = rs232_rx;
    flush_stdin();

    while(1){
        //implement command interface
        cmd = getc();
        
        switch(cmd)
        {
            //respond
            case '>':
                puts(">\n");
                break;

            //set frequency
            case 'f':
                frequency_steps = scan_udecimal();
                print_udecimal(frequency_steps);
                puts("\n");
                fputc(frequency_steps, frequency_out);
                puts(">\n");
                break;

            //set sample rate
            case 's':
                sample_rate_steps = scan_udecimal();
                print_udecimal(sample_rate_steps);
                puts("\n");
                puts(">\n");
                break;

            //set fm deviation
            case 'd':
                fm_deviation = scan_udecimal();
                print_udecimal(fm_deviation);
                puts("\n");
                puts(">\n");
                break;

            //set control
            case 'c':
                control = scan_udecimal();
                fputc(control, ctl_out);
                print_udecimal(control);
                puts("\n");
                puts(">\n");
                break;

            //mode b FM
            case 'a':
                if (timer_low() > next_sample_time){
                    next_multiple_of_8_samples = next_sample_time + (sample_rate_steps * 7);
                    if (timer_low() < next_multiple_of_8_samples){
                        next_sample_time = next_multiple_of_8_samples;
                    } else {
                        next_sample_time = timer_low() + sample_rate_steps;
                    }
                }

                length = getc();
                length |= getc() << 8;
                length &= 0x7ff; //2048 samples, 1024 bytes (half buffer size)
                //respond early so that sender can start now
                puts(">\n");

                //send samples
                for(op=0; op<length; op++){
                    sample  = getc();
                    sample |= getc() << 8;
                    sample -= 32768; //convert to signed
                    while(timer_low() < next_sample_time){}
                    send_fm(sample, frequency_steps, fm_deviation);
                    next_sample_time += sample_rate_steps;
                }
                break;

            //mode a IQ
            case 'b':

                //set frequency to carrier frequency
                fputc(frequency_steps, frequency_out);

                //send samples
                length = getc();
                length |= getc() << 8;
                length &= 0x7ff; //2048 samples, 1024 bytes (half buffer size)

                //respond early so that sender can start now
                puts(">\n");

                for(op=0; op<length; op++){
                    i = getc()-128;
                    q = getc()-128;
                    send_iq(i, q);
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
                puts(">\n");
                break;
        }
    }
}
