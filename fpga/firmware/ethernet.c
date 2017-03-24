void phy_smi_write_bit(int b)
{ int v1,v2;
  if (b) {
    v1 = 0x03;
    v2 = 0x07; }
  else {
    v1 = 0x01;
    v2 = 0x05; }
  port_write(PORT_OUT_PHY_SMI,v1);
  delay_5us();
  port_write(PORT_OUT_PHY_SMI,v2);
  delay_5us();
  port_write(PORT_OUT_PHY_SMI,v1);
  delay_5us(); }

int phy_smi_read_bit()
{ int b;
  b = port_read(PORT_IN_PHY_SMI);
  port_write(PORT_OUT_PHY_SMI,0);
  delay_5us();
  port_write(PORT_OUT_PHY_SMI,4);
  delay_5us();
  port_write(PORT_OUT_PHY_SMI,0);
  delay_5us();
  return (b&2)>>1; }

void phy_smi_write(int addr,int val)
{ int i;
  int b;
  for (i=0; i<32; i++)
    phy_smi_write_bit(1);
  phy_smi_write_bit(0);
  phy_smi_write_bit(1);
  phy_smi_write_bit(0);
  phy_smi_write_bit(1);
  phy_smi_write_bit(0);  // PHY addr (5 bits)
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  addr <<= 3;
  for (i=0; i<5; i++) {  // PHY register (5 bits)
    b = (addr&0x80)!=0;
    phy_smi_write_bit(b);
    addr <<= 1; }
  phy_smi_write_bit(1);
  phy_smi_write_bit(0);
  for (i=0; i<16; i++) {  // data (16 bits)
    b = (val&0x8000)!=0;
    phy_smi_write_bit(b);
    val <<= 1; } }

int phy_smi_read(int addr)
{ int val;
  int i;
  int b;
  for (i=0; i<32; i++)
    phy_smi_write_bit(1);
  phy_smi_write_bit(0);
  phy_smi_write_bit(1);
  phy_smi_write_bit(1);
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);  // PHY addr (5 bits)
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  phy_smi_write_bit(0);
  addr <<= 3;
  for (i=0; i<5; i++) {  // PHY register (5 bits)
    b = (addr&0x80)!=0;
    phy_smi_write_bit(b);
    addr <<= 1; }
  (void)phy_smi_read_bit();
  (void)phy_smi_read_bit();
  val = 0;
  for (i=0; i<16; i++) {  // data (16 bits)
    b = phy_smi_read_bit();
    val = (val<<1) | b; }
  return val; }

void phy_read(int addr)
{ int x;
  x = phy_smi_read(addr);
  putchar((x>>8)&0xff);
  putchar(x&0xff); }

void phy_service()
{ int r;
  int status;
  if (!uart_phy)
    return;
  r = phy_smi_read(1);
  status = (r&0x04)!=0;
  link_up = status;
  port_write(PORT_STREAMER_ENABLE,status); }
