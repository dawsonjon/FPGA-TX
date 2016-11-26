unsigned rs232_rx = input("rs232_rx");
unsigned gps_rx = input("gps_rx");
unsigned gps_count = input("gps_count");
unsigned frequency_out = output("freq_out");
unsigned am_out = output("am_out");
unsigned ctl_out = output("ctl_out");
unsigned rs232_tx = output("rs232_tx");
unsigned gps_tx = output("gps_tx");
unsigned leds = output("leds");

#include "scan.h"
#include "print.h"

void output_bar_led(unsigned value){
    value >>= 5;
    value = 8 - value;
    value = 0xff >> value;
    fputc(value, leds);
}

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
  output_bar_led(i>0?i:-i);
  fputc(sample, am_out);
}

void send_fm(signed sample, unsigned frequency_steps, unsigned fm_deviation){
  //-128 <= sample <= 127
  int frequency;
  frequency = sample*fm_deviation;
  frequency >>= 8;
  frequency += frequency_steps;
  output_bar_led(sample>0?sample:-sample >> 8);
  fputc(frequency, frequency_out);
}

void main(){

    unsigned frequency_steps = 0;
    unsigned sample_rate_steps = 8333; //default to 12k
    unsigned fm_deviation = 105; //default to 5kHz
    unsigned control = 0; //dithering off
    unsigned t0=0;
    unsigned gps_count_var=0;
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

            //get gps
            case 'g':
                gps_count_var = fgetc(gps_count);
                print_udecimal(gps_count_var);
                puts("\n");
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
                if((timer_low()-t0) > sample_rate_steps){
                    t0 = timer_low();
                }
                sample  = getc();
                sample |= getc() << 8;
                sample -= 32768; //convert to signed
                while((timer_low()-t0) < sample_rate_steps){}
                t0 += sample_rate_steps;
                send_fm(sample, frequency_steps, fm_deviation);
                break;

            //mode a IQ
            case 'b':

                fputc(frequency_steps, frequency_out);
                i = getc()-128;
                q = getc()-128;
                send_iq(i, q);

                break;

        }
    }
}
