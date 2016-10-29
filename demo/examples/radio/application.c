
unsigned eth_in = input("eth_in");
unsigned am_in = input("am_in");
unsigned fm_in = input("fm_in");
unsigned rs232_rx = input("rs232_rx");

unsigned eth_out = output("eth_out");
unsigned audio_out = output("audio_out");
unsigned frequency_out = output("frequency_out");
unsigned samples_out = output("samples_out");
unsigned rs232_tx = output("rs232_tx");

#include "ethernet.h"
#include "scan.h"
#include "print.h"

#define AUDIO_RANGE 1024
#define AUDIO_BIAS 512
#define AUDIO_MAX 511
#define AUDIO_MIN -512

#define SAMPLING_FREQUENCY 800.0e6
#define AVERAGE_SAMPLES 2048
#define AUDIO_SAMPLING_FREQUENCY SAMPLING_FREQUENCY/AVERAGE_SAMPLES

void output_audio(int sample){
    if(sample > AUDIO_MAX) sample = AUDIO_MAX;
    if(sample < AUDIO_MIN) sample = AUDIO_MIN;
    fputc(sample+AUDIO_BIAS, audio_out);
}

void main(){

    unsigned frequency_hz = 910e3;
    int min=0, max=0, range=0, attenuation=0, 
    sample=0, centre=0;
    unsigned audio_leak = 2;
    char c;

    stdout = rs232_tx;
    stdin = rs232_rx;

    puts("a for am f for fm:\n");
    c = getc();
    if( c == 'a'){
        fputc(8192, samples_out);
        puts("Enter frequency in hz:\n");
        frequency_hz = scan_udecimal();
        puts("calculating frequency:\n");
        fputc((int)(frequency_hz/(SAMPLING_FREQUENCY/4294967296.0)), frequency_out);
        puts("playing audio:\n");

        while(1){

            
            sample = fgetc(am_in);

            //automatic gain control
            if(sample > max) max = sample;
            if(sample < min) min = sample;
            centre = (max+min)>>1;
            range = (max-min);
            attenuation = (range + AUDIO_RANGE)/AUDIO_RANGE;
            output_audio((sample-centre) / attenuation);

            if(range > 2){
                max -= 1;
                min += 1;
            }

        }
    } else {
        fputc(1024, samples_out);
        puts("Enter frequency in hz:\n");
        frequency_hz = scan_udecimal();
        puts("calculating frequency:\n");
        fputc((int)(frequency_hz/(SAMPLING_FREQUENCY/4294967296.0)), frequency_out);
        puts("playing audio:\n");

        while(1){

            
            sample = ((int)fgetc(fm_in)) >> 2;
            sample += ((int)fgetc(fm_in)) >> 2;

            //automatic gain control
            if(sample > max) max = sample;
            if(sample < min) min = sample;
            centre = (max+min)>>1;
            range = (max-min);


            attenuation = (range + AUDIO_RANGE)/AUDIO_RANGE;
            output_audio((sample-centre) / attenuation);
            //if(range > 2){
            //    max -= 1;
            //    min += 1;
            //}
        }
    }


}
