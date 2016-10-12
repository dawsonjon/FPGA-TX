
unsigned eth_in = input("eth_in");
unsigned audio_in = input("audio_in");
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

#define SAMPLING_FREQUENCY 200.0e6
#define AVERAGE_SAMPLES 8192
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

    stdout = rs232_tx;
    stdin = rs232_rx;

    fputc(AVERAGE_SAMPLES, samples_out);
    puts("Enter frequency in hz:\n");
    frequency_hz = scan_udecimal();
    puts("calculating frequency:\n");
    fputc((int)(frequency_hz/(SAMPLING_FREQUENCY/4294967296.0)), frequency_out);
    puts("playing audio:\n");

    while(1){

        
        sample = fgetc(audio_in);

        //automatic gain control
        if(sample > max) max = sample;
        if(sample < min) min = sample;
        centre = (max+min)>>1;
        range = (max-min);


        attenuation = (range + AUDIO_RANGE)/AUDIO_RANGE;

        //attenuation = 0;
        //while((range>>attenuation) > AUDIO_RANGE){
            //attenuation++;
        //}

        output_audio((sample-centre) / attenuation);
        //if(!audio_leak--){
            //audio_leak = 100;
            if(range > 2){
                max -= 1;
                min += 1;
            }
        //}

        //print_decimal(min);
        //puts(" ");
        //print_decimal(max);
        //puts(" ");
        //print_decimal(centre);
        //puts(" ");
        //print_decimal(attenuation);
        //puts("\n");
    }


}
