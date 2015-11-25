#include "adt7420.h"
#include <stdio.h>
#include <print.h>

unsigned i2c_in = input("i2c_in");
unsigned i2c_out = output("i2c_out");
unsigned rs232_tx = output("rs232_tx");

void main(){
    unsigned temp;
    i2c bus;
    adt7420 temp_sensor;

    stdout = rs232_tx;

    puts("\nChips-2.0 temperature sensor demo\n");

    /*initialise I2CBUS*/
    puts("Initialising I2C bus\n");
    i2c_init(&bus, i2c_in, i2c_out);

    /*initialise ADT7420*/
    puts("Initialising ADT7420 bus\n");
    adt7420_init(&temp_sensor, &bus, 3);

    while(1){
       /*Get temperature reading*/
       temp = adt7420_get_temp(&temp_sensor);
       print_float(temp * 0.0625f);
       puts(" degrees C\n");
       wait_clocks(50000000);
    }
}
