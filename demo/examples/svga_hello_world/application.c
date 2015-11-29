#include <stdio.h>
#include <print.h>
#include "vga.h"

unsigned vga_out = output("vga_out");
unsigned rs232_out = output("rs232_out");

void vga_print(vga * self, int c[]){
    unsigned i, j;
    while(1){
        j = c[i++];
        if(!j) return;
        vga_put_char(self, j);
    }
}

void main(){
    vga vga1;
    stdout = rs232_out;
    puts("Chips svga hello world\n");
    vga_init(&vga1, vga_out);
    vga_print(&vga1, "Hello World!");
}
