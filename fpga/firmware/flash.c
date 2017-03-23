int spi_byte(int x)
{ int i;
  int mask = 0x80;
  int r = 0;
  int v1,v2,v3;
  int b;
  for (i=0; i<8; i++) {
    if (x&mask) {
      v1 = 0;
      v2 = 4;
      v3 = 0; }
    else {
      v1 = 2;
      v2 = 6;
      v3 = 2; }
    mask >>= 1;
    port_write(PORT_FLASH_SPI_OUT,v1);
    delay_200ns();
    port_write(PORT_FLASH_SPI_OUT,v2);
    delay_200ns();
    b = port_read(PORT_FLASH_SPI_IN);
    r = (r<<1) | b;
    port_write(PORT_FLASH_SPI_OUT,v3);
    delay_200ns(); }
  return r; }

void spi_start()
{ port_write(PORT_FLASH_SPI_OUT,1);
  delay_200ns();
  port_write(PORT_FLASH_SPI_OUT,0);
  delay_200ns(); }

void spi_end()
{ port_write(PORT_FLASH_SPI_OUT,1);
  delay_200ns(); }

int spi_read(int addr)
{ int x;
  spi_start();
  (void)spi_byte(0x03);
  (void)spi_byte((addr>>16)&0xff);
  (void)spi_byte((addr>>8)&0xff);
  (void)spi_byte(addr&0xff);
  x = spi_byte(0);
  spi_end();
  return x; }

void spi_init_mac()
{ int i,x;
  for (i=0; i<6; i++) {
    x = spi_read(0x7ff00+i);
    port_write(PORT_MAC_ADDR+i,x); } }
