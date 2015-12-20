#include <stdio.h>
#include <ctype.h>
#include "enigma.h"

unsigned rs232_in = input("rs232_in");
unsigned rs232_out = output("rs232_out");

enigma theenigma;

char * rotor_l;
char * rotor_m;
char * rotor_r;
char * reflector;

char ring_setting_l;
char ring_setting_m;
char ring_setting_r;

char l;
char m;
char r;

char * select_rotor(){
    char key;
    while(1){
        key = getc();
        if(key == '1') return &rotor_i[0];
        if(key == '2') return &rotor_ii[0];
        if(key == '3') return &rotor_iii[0];
        if(key == '4') return &rotor_iv[0];
        if(key == '5') return &rotor_v[0];
    }
}

char * select_reflector(){
    char key;
    while(1){
        key = getc();
        if(toupper(key) == 'A') return &reflector_a[0];
        if(toupper(key) == 'B') return &reflector_b[0];
        if(toupper(key) == 'C') return &reflector_c[0];
    }
}

char get_key(){
    char key;
    while(1){
        key = getc();
        if(isalpha(key)) return toupper(key);
    }
}

void initialise(){
    enigma_init(&theenigma, 
        rotor_l, rotor_m, rotor_r, reflector,
        ring_setting_l, ring_setting_m, ring_setting_r,
        l, m, r
    );
    puts("Rotor positions: "); putc(l); putc(m); putc(r); puts("\n");
}

void main(){
    stdout = rs232_out;
    stdin = rs232_in;

    unsigned i;
    char key;

    rotor_l = &rotor_i[0];
    rotor_m = &rotor_ii[0];
    rotor_r = &rotor_iii[0];
    reflector = &reflector_b[0];
    ring_setting_l = 'A';
    ring_setting_m = 'A';
    ring_setting_r = 'A';
    l = 'A';
    m = 'A';
    r = 'A';
    initialise();

    puts("Enigma Machine\n");
    puts("==============\n\n");
    puts("1. Wheel settings (Walzenlage) (1->5) left, middle, right e.g. 123\n");
    puts("2. Reflector (a->c) e.g. b\n");
    puts("3. Ring settings (Ringstellung) (a->z) left, middle, right e.g. aaa\n");
    puts("4. Rotor positions (a->z) left, middle, right e.g. aaa\n");
    puts("ready ...\n");

    i=0;
    while(1){
        key = getc();
        if (isalpha(key)) {
            if(i==0){
              putc('A' + theenigma.l); 
              putc('A' + theenigma.m); 
              putc('A' + theenigma.r); 
              puts(": ");
            }
            putc(enigma_encrypt(&theenigma, toupper(key)));
            if(i==70) {
                i=0;
                putc('\n');
            } else {
                i++;
            }
        } else if (isdigit(key)) {
            if (key == '1') {
               puts("\n>\n");
               rotor_l = select_rotor();
               rotor_m = select_rotor();
               rotor_r = select_rotor();
               initialise();
               i=0;
            } else if (key == '2') {
               puts("\n>\n");
               reflector = select_reflector();
               initialise();
               i=0;
            } else if (key == '3') {
               puts("\n>\n");
               ring_setting_l = get_key();
               ring_setting_m = get_key();
               ring_setting_r = get_key();
               initialise();
               i=0;
            } else if (key == '4') {
               puts("\n>\n");
               l = get_key();
               m = get_key();
               r = get_key();
               initialise();
               i=0;
            }
        }
    }
}
