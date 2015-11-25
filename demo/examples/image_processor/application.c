#include <stdio.h>
#include <print.h>


unsigned eth_out = output("eth_out");
unsigned rs232_out = output("rs232_out");
unsigned eth_in = input("eth_in");
#include "ethernet.h"

#define WIDTH 256
#define HEIGHT 256

void set_xy(int image[], int x, int y, int pixel){
    if(x<0) return;
    if(x>=WIDTH) return;
    image[x+y*WIDTH] = pixel;
}

int get_xy(int image[], int x, int y){
    if(x<0) return 0;
    if(x>=WIDTH) return 0;
    return image[x+y*WIDTH];
}

void main(){
    unsigned image[256*256];
    unsigned new_image[256*256];
    int x, y, pixel;

    unsigned data0[256];
    unsigned data1[256];
    unsigned data2[256];
    unsigned buffer[256];

    unsigned *above;
    unsigned *centre;
    unsigned *below;
    unsigned length;
    stdout = rs232_out;

    puts("Chips image processing example\n");

    above = &data0[0];
    centre = &data1[0];
    below = &data2[0];
    while(1){
        /* apply edge detect */
        //for(y=0; y<HEIGHT; y++){

            below = centre;
            centre = above;
            length = ethernet_get_data(above);

            for(x=0; x<WIDTH; x++){
                pixel =  centre[x] << 2;
                if(x > 0){
                    pixel -= above[x-1];
                    pixel -= below[x-1];
                }
                if(x < WIDTH-1){
                    pixel -= below[x+1];
                    pixel -= above[x+1];
                }
                buffer[x] = pixel;
            }

            ethernet_put_data(buffer, length);

        //}
    }
}
