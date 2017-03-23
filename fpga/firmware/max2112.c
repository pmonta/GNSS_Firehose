#define MAX2112_I2C_SLAVE_ADDR     0x60

void i2c_write(int channel,int addr,int val)
{}

void i2c_set_sda(int channel,int val)
{}

void i2c_set_scl(int channel,int val)
{}

void i2c_init(int channel)
{ i2c_set_sda(channel,1);
  i2c_set_scl(channel,1); }

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
  i2c_write(channel,3,(F>>12)&0xff);
  i2c_write(channel,4,0x00);
  i2c_write(channel,0,0x80); }

#define N_CHANNEL 3
int gain[N_CHANNEL+1];

void set_agc(int channel,int val)
{ int port_base = PORT_OUT_PWM+2*(channel-1);
  if (channel>N_CHANNEL)
    return;
  port_write(port_base,val&0xff);
  port_write(port_base+1,(val>>8)&0x3);
  gain[channel] = val; }
