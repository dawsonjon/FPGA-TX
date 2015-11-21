#include <stdio.h>
#include <print.h>

/// Bits (7:0)
/// /////////-
/// (For write byte only) data payload byte
///
/// Bit (8)
/// //////-
/// 1 = read byte
/// 0 = write byte
///
/// Bit (9)
/// //////-
/// 1 = SEND_START
///
/// Bit (10)
/// //////--
/// 1 = SEND_STOP
///
/// Bit (11)
/// //////--
/// (For read byte only) 1 = SEND_ACK
///
/// RESPONSE
/// ========
///
/// Bits (7:0)
/// /////////-
/// (For read byte only) data payload byte
///
/// Bit (0)
/// //////-
/// (For write byte only) 1 = NACK, 0 = ACK
///

#define READ_WRITE (1 << 8)
#define SEND_START (1<<9)
#define SEND_STOP (1<<10)
#define SEND_NACK (1<<11)

#define GOT_NACK 1

typedef struct{
    unsigned in;
    unsigned out;
} i2c;

void i2c_init(i2c * self, unsigned in, unsigned out){
    self -> in = in;
    self -> out = out;
}

/* Write a byte to I2C bus. Return 0 if ack by the slave.*/
int i2c_write_byte(
    i2c *self,
    int send_start,
    int send_stop,
    unsigned byte
) {
  unsigned flags = 0;
  unsigned return_value;
  if(send_start) flags |= SEND_START; 
  if(send_stop)  flags |= SEND_STOP; 
  fputc(flags | byte, self->out);
  return_value = fgetc(self->in);
  return return_value & GOT_NACK;
}

// Read a byte from I2C bus
unsigned char i2c_read_byte(
    i2c *self,
    int nack, 
    int send_stop
) {
  unsigned flags = 0;
  unsigned return_value;
  if(send_stop)  flags |= SEND_STOP; 
  if(nack)  flags |= SEND_NACK; 
  flags |= READ_WRITE;
  fputc(flags, self->out);
  return_value = fgetc(self->in);
  return return_value & 0xff;
}
