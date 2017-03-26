// GNSS Firehose firmware
//
// Copyright 2017 Peter Monta
//

unsigned int jiffies;           // system time
unsigned char addr;             // remote command address
unsigned char data;             // remote command data
int uart_phy;                   // who has control of Ethernet PHY SMI bus
int link_up;                    // Ethernet link status
int auto_agc;                   // AGC automatic or manual

#define N_CHANNEL 3

int gain[N_CHANNEL];            // channel gains (10-bit PWM)

#include "io.c"
#include "delay.c"
#include "clock.c"
#include "adc.c"
#include "max2112.c"
#include "agc.c"
#include "ethernet.c"
#include "flash.c"

int scratchpad(int addr)
{ switch (addr) {
    case 0: return gain[0]&0xff; break;
    case 1: return (gain[0]>>8)&0xff; break;
    case 2: return gain[1]&0xff; break;
    case 3: return (gain[1]>>8)&0xff; break;
    case 4: return gain[2]&0xff; break;
    case 5: return (gain[2]>>8)&0xff; break;
    default: return 0; } }

void process_char(char c)
{ switch (c) {
    case 'm':  addr = data; break;
    case 'w':  port_write(addr,data); break;
    case 'r':  putchar(port_read(addr)); break;
    case 'x':  putchar(addr); break;
    case 'p':  phy_read(addr); break;
    case 'f':  putchar(spi_read(0x7ff00+addr)); break;
    case 's':  putchar(scratchpad(addr)); break;
    default:  data = (data<<4) | (c&0x0f); data &= 0xff; break; } }

void eth_service()
{ if (!eth_rx_ready())
    return;
  process_char(eth_rx_data()); }

void uart_service()
{ if (!uart_rx_ready())
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
  uart_phy = 0;                // control of PHY SMI bus is initially local, not UART
  auto_agc = 1;                // enable automatic AGC by default
  spi_init_mac();              // initialize MAC address from flash
//  port_write(PORT_DC_BASE+0,6);   //fixme: read these from flash
//  port_write(PORT_DC_BASE+1,3);
//  port_write(PORT_DC_BASE+2,5);
//  port_write(PORT_DC_BASE+3,3);
//  port_write(PORT_DC_BASE+4,8);
//  port_write(PORT_DC_BASE+5,5);
}

void poll()
{ unsigned int j;
  j = get_jiffies();
  if (j==jiffies)          // has jiffies counter changed?
    return;
  jiffies = j;             // do once per jiffy:
  agc_service();           // service the AGC loops
  phy_service(); }         // poll Ethernet PHY for link status

//
// main loop
//

int main()
{ hw_init();            // initialize hardware

  for (;;) {
    uart_service();     // service any UART commands
    eth_service();      // service any Ethernet commands
    poll(); }           // low-rate polling of various background services

  return 0; }
