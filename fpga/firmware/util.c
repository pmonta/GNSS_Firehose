#include "util.h"

#define UART_RX_DATA   0x80000080
#define UART_RX_READY  0x80000084
#define UART_TX_READY  0x80000088

#define UART_TX_DATA   0x80000080
#define UART_RX_READ   0x80000084
#define UART_TX_WRITE  0x80000088

void uart_tx_data(int x)
{ *(volatile unsigned int*)UART_TX_DATA = x;
  *(volatile unsigned int*)UART_TX_WRITE = 1;
  *(volatile unsigned int*)UART_TX_WRITE = 0; }

int uart_tx_ready()
{ return *(volatile unsigned int*)UART_TX_READY; }

int uart_rx_data()
{ unsigned int x;
  x = *(volatile unsigned int*)UART_RX_DATA;
  *(volatile unsigned int*)UART_RX_READ = 1;
  *(volatile unsigned int*)UART_RX_READ = 0;
  return x; }

int uart_rx_ready()
{ return *(volatile unsigned int*)UART_RX_READY; }

void delay(int m)
{ int i;
  for (i=0; i<m; i++) {
    asm volatile("nop"); } }

void putc(char c)
{ while (!uart_tx_ready()) ;
  uart_tx_data(c); }

void puts(char* s)
{ char c;
  while (c=*s++)
    putc(c); }

char getc()
{ while (!uart_rx_ready()) ;
  return uart_rx_data(); }

void put_nib(unsigned int x)
{ putc(x<10 ? '0'+x : 'a'+(x-10)); }

void put_hex(unsigned int x)
{ int i;
  for (i=0; i<8; i++)
    put_nib((x>>(32-4*(i+1)))&0xf); }

void put_dec(unsigned int x)
{ int i;
  int n;
  int leading = 0;
  for (i=1000000000; i>=1; i=i/10) {
    n = x/i;
    if (leading || (n!=0))
      put_nib(n);
    leading = leading || (n!=0);
    x -= i*n; } }
