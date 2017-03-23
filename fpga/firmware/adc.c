void adc_cs(int channel,int val)
{ port_write(PORT_SPI+channel,val ? 0x09 : 0x01); }

void adc_write_bit(int channel,int b)
{ int v1,v2;
  if (b==0) {
    v1 = 1;
    v2 = 5; }
  else {
    v1 = 3;
    v2 = 7; }
  port_write(PORT_SPI+channel,v1);
  delay_5us();
  port_write(PORT_SPI+channel,v2);
  delay_5us();
  port_write(PORT_SPI+channel,v1);
  delay_5us(); }

void adc_write(int channel,int addr,int val)
{ int i,b;
  adc_cs(channel,0);
  adc_write_bit(channel,0);
  for (i=6; i>=0; i--) {
    b = (addr>>i)&1;
    adc_write_bit(channel,b); }
  for (i=7; i>=0; i--) {
    b = (val>>i)&1;
    adc_write_bit(channel,b); }
  adc_cs(channel,1); }

void adc_init(int channel)
{ adc_cs(channel,1);
  adc_write(channel,0,0x03);
  adc_write(channel,1,0x1a);    // 000 BIT_ORDER_B=1 BIT_ORDER_A=1 MUX_CH=0 MUX=1 0
  adc_write(channel,3,0x07);
  adc_write(channel,4,0x1b);    // 00 CT_DCLK_A=011 CT_DATA_A=011
  adc_write(channel,5,0x1b);    // 00 CT_DCLK_A=011 CT_DATA_A=011
  adc_write(channel,6,0x28);    // TEST_PATTERN=0 TEST_DATA=0 FORMAT=10(Gray) TERM_100=1 SYNC_MODE=0 DIV=00
  adc_write(channel,8,0x88); }
