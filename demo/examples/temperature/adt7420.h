#include "i2c.h"
void write_register_single(i2c * self, unsigned address, unsigned data){
    i2c_write_byte(self, 1, 0, 0x4b << 1);
    i2c_write_byte(self, 0, 0, address);
    i2c_write_byte(self, 0, 1, data);
}
void write_register_double(i2c * self, unsigned address, unsigned data){
    i2c_write_byte(self, 1, 0, 0x4b << 1);
    i2c_write_byte(self, 0, 0, address);
    i2c_write_byte(self, 0, 0, data>>8);
    i2c_write_byte(self, 0, 1, data);
}
unsigned read_register_single(i2c * self, unsigned address){
    i2c_write_byte(self, 1, 0, 0x4b << 1);
    i2c_write_byte(self, 0, 0, address);
    i2c_write_byte(self, 1, 0, 0x4b << 1 | 1);
    return i2c_read_byte(self, 1, 1);
}
unsigned read_register_double(i2c * self, unsigned address){
    unsigned data;
    i2c_write_byte(self, 1, 0, 0x4b << 1);
    i2c_write_byte(self, 0, 0, address);
    i2c_write_byte(self, 1, 0, 0x4b << 1 | 1);
    data = i2c_read_byte(self, 0, 0) << 16;
    data |= i2c_read_byte(self, 1, 1);
    return data;
}
