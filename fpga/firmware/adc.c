void adc_cs(int channel,int val)
{ if ((channel<1) || (channel>N_ADC))
    return;
  port_write(PORT_ADC_SPI_OUT+(channel-1),val ? 0x09 : 0x01);
  delay_5us(); }

void adc_write_bit(int channel,int b)
{ int v1,v2;
  if ((channel<1) || (channel>N_ADC))
    return;
  if (b==0) {
    v1 = 1;
    v2 = 5; }
  else {
    v1 = 3;
    v2 = 7; }
  port_write(PORT_ADC_SPI_OUT+(channel-1),v1);
  delay_5us();
  port_write(PORT_ADC_SPI_OUT+(channel-1),v2);
  delay_5us();
  port_write(PORT_ADC_SPI_OUT+(channel-1),v1);
  delay_5us(); }

int adc_read_bit(int channel)
{ int b;
  if ((channel<1) || (channel>N_ADC))
    return 0;
  port_write(PORT_ADC_SPI_OUT+(channel-1),0x00);
  delay_5us();
  b = port_read(PORT_ADC_SPI_IN+(channel-1));
  b = b&1;
  port_write(PORT_ADC_SPI_OUT+(channel-1),0x04);
  delay_5us();
  port_write(PORT_ADC_SPI_OUT+(channel-1),0x00);
  delay_5us();
  return b; }

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

int adc_read(int channel,int addr)
{ int i,b,x;
  adc_cs(channel,0);
  adc_write_bit(channel,1);
  for (i=6; i>=0; i--) {
    b = (addr>>i)&1;
    adc_write_bit(channel,b); }
  x = 0;
  for (i=0; i<8; i++)
    x = (x<<1) | adc_read_bit(channel);
  adc_cs(channel,1);
  return x; }

void adc_init(int channel)
{ adc_cs(channel,1);
  adc_write(channel,0,0x03);
  adc_write(channel,1,0x1a);    // 000 BIT_ORDER_B=1 BIT_ORDER_A=1 MUX_CH=0 MUX=1 0
  adc_write(channel,3,0x07);
  adc_write(channel,4,0x09);    // 00 CT_DCLK_A=001 CT_DATA_A=001
  adc_write(channel,5,0x09);    // 00 CT_DCLK_A=001 CT_DATA_A=001
  adc_write(channel,6,0x28);    // TEST_PATTERN=0 TEST_DATA=0 FORMAT=10(Gray) TERM_100=1 SYNC_MODE=0 DIV=00
  adc_write(channel,8,0x88); }
