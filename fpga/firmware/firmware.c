// GNSS Firehose firmware
//
// Copyright 2017 Peter Monta
//

#include "io.c"
#include "delay.c"
#include "clock.c"
#include "adc.c"
#include "max2112.c"

unsigned int jiffies;           // system time
unsigned char addr;             // remote command address
unsigned char data;             // remote command data

void putchar(char c)
{ while (!uart_tx_ready()) ;
  uart_tx_data(c); }

//fixme: also write a single-character packet to Ethernet
//  while (eth_link_up && !eth_tx_ready()) ;
//  eth_tx_data(c);

void puts(char* s)
{ char c;
  while (c=*s++)
    putchar(c); }

void process_char(char c)
{ switch (c) {
    case 'm':  addr = data; break;
    case 'w':  port_write(addr,data); break;
    case 'r':  putchar(port_read(addr)); break;
    case 'x':  putchar(addr); break;
    case 'p':  putchar(phy_read(addr)); break;
    default:  data = (data<<4) | (c&0x0f); data &= 0xff; break; } }

//void eth_service()
//{ int r;
//  r = eth_rx_ready();
//  if (r==0)
//    return;
//  process_char(eth_rx_data()); }

void uart_service()
{ int r;
  if (!uart_rx_ready())
    return;
  process_char(uart_rx_data()); }

void hw_init()
{ clock_init();
  port_write(PORT_DCM_RST,1);
  delay_10ms();
  port_write(PORT_DCM_RST,0);
  delay_10ms();
  adc_init(1);
  adc_init(2);
  adc_init(3);
  adc_init(4);
  max2112_init(1,45,0x4a000);  // RF channel 1, N=45 (L1), F=0x4a000
  max2112_init(2,35,0x16000);  // RF channel 2, N=35 (L2), F=0x16000
  max2112_init(3,34,0x0e000);  // RF channel 3, N=34 (L5), F=0x0e000
  set_agc(1,240);              // initial AGC value: 240
  set_agc(2,240);
  set_agc(3,240);
//  scratch_uart_phy = 0;        // control of PHY SMI bus is initially local
//  scratch_auto_agc = 1;        // enable automatic AGC by default
//  spi_init_mac(); }            // initialize MAC address from flash
}

void poll()
{ unsigned int j;
  j = get_jiffies();
  if (j==jiffies)          // has jiffies counter changed?
    return;
  jiffies = j;
//  agc_service();           // service the AGC loops
//  phy_service(); }         // poll Ethernet PHY for link status
}

int main()
{ hw_init();            // initialize hardware

  for (;;) {
    uart_service();     // service any UART commands
//    eth_service();      // service any Ethernet commands
    poll(); }           // low-rate polling of various background services

  return 0; }
