void delay(int m)
{ int i;
  for (i=0; i<m; i++) {
    asm volatile("nop"); } }

void delay_200ns()
{ asm volatile("nop");
  asm volatile("nop");
  asm volatile("nop"); }

void delay_5us()
{ delay(13); }

void delay_20us()
{ delay(52); }

void delay_100us()
{ delay(260); }

void delay_10ms()
{ delay(25920); }

void delay_100ms()
{ delay(259200); }

void delay_1500ms()
{ delay(3888000); }
