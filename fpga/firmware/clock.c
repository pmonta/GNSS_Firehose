void clock_write_bit(int b)
{ int v1,v2,v3;
  if (b) {
    v1 = 2;
    v2 = 6;
    v3 = 2; }
  else {
    v1 = 0;
    v2 = 4;
    v3 = 0; }
  clock_out(v1);
  delay_5us();
  clock_out(v2);
  delay_5us();
  clock_out(v3);
  delay_5us(); }

int clock_read_bit()
{ int b;
  clock_out(0x04);
  delay_5us();
  b = port_read(PORT_CLOCK_IN);
  b = (b>>1)&1;
  delay_5us();
  clock_out(0x00);
  delay_5us();
  return b; }

void clock_le()
{ clock_out(0);
  delay_5us();
  clock_out(1);
  delay_5us();
  clock_out(0);
  delay_5us(); }

void clock_write(unsigned int x)
{ int i,b;
  for (i=0; i<32; i++) {
    b = (x&0x80000000)!=0;
    clock_write_bit(b);
    x <<= 1; }
  clock_le(); }

unsigned int clock_read(int addr)
{ int i;
  unsigned int x;
  clock_write((addr<<16)|31);
  x = 0;
  for (i=0; i<32; i++)
    x = (x<<1) | clock_read_bit();
  return x; }

#define N_CLOCK_W 28
unsigned int clock_w[N_CLOCK_W] = {
  0x80020460, 0x00000460, 0x00000460, 0x00000461, 0x00000461, 0x80000462, 0x80000462, 0x00000463,
  0x00000463, 0x00000464, 0x00000464, 0x00000465, 0x00000465, 0x06660006, 0x01000007, 0x11110008,
  0x55555549, 0x1000400a, 0x3400000b, 0x130c006c, 0x3b02066d, 0x0200000e, 0xc1550410, 0x00000018,
  0x83a8001a, 0x0010001c, 0x008002bd, 0x030002be, 
};

void clock_init()
{ int i;
  for (i=0; i<N_CLOCK_W; i++)
    clock_write(clock_w[i]);
  delay_100ms();
  clock_write(0x3401000b);
  delay_100ms();
  clock_write(0x3400000b);
  delay_100ms(); }
