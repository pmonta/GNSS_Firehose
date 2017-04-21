int spi_byte(int x)
{ int i;
  int mask = 0x80;
  int r = 0;
  int v1,v2,v3;
  int b;
  for (i=0; i<8; i++) {
    if (x&mask) {
      v1 = 2;
      v2 = 6;
      v3 = 2; }
    else {
      v1 = 0;
      v2 = 4;
      v3 = 0; }
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

void spi_write_enable()
{ spi_start();
  spi_byte(0x06);
  spi_end(); }

void spi_write(int addr,unsigned char val)
{ spi_write_enable();
  spi_start();
  (void)spi_byte(0x02);
  (void)spi_byte((addr>>16)&0xff);
  (void)spi_byte((addr>>8)&0xff);
  (void)spi_byte(addr&0xff);
  (void)spi_byte(val);
  spi_end();
  delay_20us(); }

void spi_sector_erase(int addr)
{ spi_write_enable();
  spi_start();
  (void)spi_byte(0xd8);
  (void)spi_byte((addr>>16)&0xff);
  (void)spi_byte((addr>>8)&0xff);
  (void)spi_byte(addr&0xff);
  spi_end();
  delay_1500ms(); }

#define PKT_MAC_ADDR       1
#define PKT_DC_OFFSET      2

void spi_read_config()
{ int addr;
  unsigned char type, val, len;
  int i;
  addr = 0x7ff00;
  while ((addr<0x7ffff) && (type=spi_read(addr))!=0xff) {   // iterate over (type,length,packet) fields in flash
    addr++;
    len = spi_read(addr);
    addr++;
    switch (type) {
      case PKT_MAC_ADDR:                         // initialize MAC address from flash
        for (i=0; i<6; i++)
          val = spi_read(addr+i);
          port_write(PORT_MAC_ADDR+i,val);
        addr += len;
        break;
      case PKT_DC_OFFSET:                        // DC offsets of RF-channel ADCs
        for (i=0; i<6; i++)
          val = spi_read(addr+i);
          port_write(PORT_DC_BASE+i,val);
        addr += len;
        break;
      default:                                   // unknown type
        addr += len;
        break; } } }
