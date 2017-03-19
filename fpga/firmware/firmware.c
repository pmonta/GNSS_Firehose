#include "util.h"

int main()
{ int i;
  char c;
  unsigned int a,b,y;

  delay(10000);
  puts("picorv32\n");

  a = 23;
  b = 45;
  y = a*b;
  puts("23 * 45 = "); put_dec(y); putc('\n');

  i = 0;
  for (;;) {
    c = getc();
    putc(c+1);
    i++;
    led(i); }

  return 0; }
