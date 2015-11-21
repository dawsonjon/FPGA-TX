#include "adt7420.h"
#include <stdio.h>

unsigned i2c_in = input("i2c_in");
unsigned i2c_out = output("i2c_out");
unsigned rs232_tx = output("rs232_tx");

void main(){
    int count;
    unsigned temp;
    i2c *temp_sensor;

    stdout = rs232_tx;
    i2c_init(temp_sensor, i2c_in, i2c_out);
    puts("Chips-2.0 temperature sensor demo\n");

    while(1){
       i2c_write_byte(temp_sensor, 1, 0, (0x4b << 1) | 1);
       temp = i2c_read_byte(temp_sensor, 0, 0) << 8;
       temp |= i2c_read_byte(temp_sensor, 1, 1);
       temp >>= 3;
       print_double(temp * 0.0625);
       puts(" degrees C\n");
    }
}
