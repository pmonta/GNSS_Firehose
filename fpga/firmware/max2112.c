#define MAX2112_I2C_SLAVE_ADDR     0x60

void i2c_set_sda(int channel,int val)
{ int x;
  int port = PORT_I2C + (channel-1);
  if ((channel<1) || (channel>N_CHANNEL))
    return;
  x = port_read(port);
  x = (x&0xfd) | (val<<1);
  port_write(port,x);
  delay_5us(); }

void i2c_set_scl(int channel,int val)
{ int x;
  int port = PORT_I2C + (channel-1);
  if ((channel<1) || (channel>N_CHANNEL))
    return;
  x = port_read(port);
  x = (x&0xfe) | (val);
  port_write(port,x);
  delay_5us(); }

void i2c_bit(int channel,int bit)
{ i2c_set_sda(channel,bit);
  i2c_set_scl(channel,1);
  i2c_set_scl(channel,0); }

void i2c_bits(int channel,int x,int bits)
{ int i,b;
  for (i=bits-1; i>=0; i--) {
    b = (x&(1<<i))!=0;
    i2c_bit(channel,b); } }

int i2c_get_bit(int channel)
{ int b;
  i2c_set_sda(channel,1);
  i2c_set_scl(channel,1);
  //fixme: read bit from sda
  b = 0;
  i2c_set_scl(channel,0);
  return b; }

void i2c_ack(int channel)
{ (void)i2c_get_bit(channel); }

void i2c_start(int channel)
{ i2c_set_sda(channel,0);
  i2c_set_scl(channel,0); }

void i2c_stop(int channel)
{ i2c_set_scl(channel,1);
  i2c_set_sda(channel,1); }

void i2c_init(int channel)
{ i2c_set_sda(channel,1);
  i2c_set_scl(channel,1); }

void i2c_write(int channel,int addr_reg,int val)
{ i2c_start(channel);
  i2c_bits(channel,MAX2112_I2C_SLAVE_ADDR,7);
  i2c_bit(channel,0);
  i2c_ack(channel);
  i2c_bits(channel,addr_reg,8);
  i2c_ack(channel);
  i2c_bits(channel,val,8);
  i2c_ack(channel);
  i2c_stop(channel); }

void max2112_init(int channel,int N,int F)
{ i2c_init(channel);
  i2c_write(channel,5,0x02);
  i2c_write(channel,6,0x40);
  i2c_write(channel,7,0xcc);
  i2c_write(channel,8,0x5c);
  i2c_write(channel,9,0x07);
  i2c_write(channel,10,0x00);
  i2c_write(channel,11,0x08);
  i2c_write(channel,1,N);
  i2c_write(channel,2,0x10|((F>>16)&0xf));
  i2c_write(channel,3,(F>>8)&0xff);
  i2c_write(channel,4,F&0xff);
  i2c_write(channel,0,0x80); }
