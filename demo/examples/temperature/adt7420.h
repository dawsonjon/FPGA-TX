#include "i2c.h"

typedef struct {
  i2c *bus;
  unsigned target_address;
} adt7420;

/* initialise temperature sensor */
void adt7420_init(adt7420 * self, i2c * bus, unsigned target_address){
	self->bus = bus;
	self->target_address = target_address;
	while(1){
	  //allow 1 second from power up
          if(timer_low() > 50000000) return;
	}
}

/* Return the current temperature in 0.0625 degree C steps */
unsigned adt7420_get_temp(adt7420 *self){
       unsigned temp;
       unsigned target_address;

       /*calculate i2c address of adt7420 based on address pins*/
       target_address = 0x48 | self->target_address;

       i2c_write_byte(self->bus, I2C_START_FLAG | (target_address<< 1) | 1);
       temp  = i2c_read_byte(self->bus, 0) << 8;
       temp |= i2c_read_byte(self->bus, I2C_STOP_FLAG | I2C_NACK_FLAG);
       temp >>= 3;
       return temp;
}
