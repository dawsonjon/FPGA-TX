#include <stdio.h>
#include <print.h>
#include <math.h>

unsigned rs232_tx = output("rs232_tx");

void main(){

    unsigned start_time, finish_time;
    int i;
    float fvalue = 1.0f;
    const float clock_frequency = 50.0f;
    const float clock_period = 1.0f/clock_frequency;

    stdout = rs232_tx;

    puts("calculate 1000 floating point adds\n");
    start_time = timer_low();
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
         fvalue += 1.001f;
    }
    finish_time = timer_low();
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");

    puts("calculate 1000 floating point multiplies\n");
    start_time = timer_low();
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
         fvalue *= 1.001f;
    }
    finish_time = timer_low();
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");

    puts("calculate 1000 floating point divides\n");
    start_time = timer_low();
    fvalue = 1.0f;
    for(i=0; i<100; ++i){
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
         fvalue /= 1.001f;
    }
    finish_time = timer_low();
    puts("MFLOPS: "); print_float(1000.0f/((finish_time - start_time)*clock_period)); puts("\n\n");

}
