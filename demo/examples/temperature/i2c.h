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

#define I2C_START_FLAG (1<<9)
#define I2C_STOP_FLAG (1<<10)
#define I2C_NACK_FLAG (1<<11)

#define READ_WRITE (1 << 8)
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
    unsigned byte
) {
  unsigned return_value;
  fputc(byte, self->out);
  return fgetc(self->in) & GOT_NACK;
}

/* Read a byte from I2C bus */
unsigned char i2c_read_byte(
    i2c *self,
    unsigned flags
) {
  flags |= READ_WRITE;
  fputc(flags, self->out);
  return fgetc(self->in) & 0xff;
}
