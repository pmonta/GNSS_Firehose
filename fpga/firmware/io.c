// output ports

#define PORT_CLOCK             0
#define PORT_LED               2
#define PORT_OUT_PHY_SMI       4
#define PORT_OUT_PWM           6
#define PORT_SPI              12
#define PORT_DCM_RST          30
#define PORT_UART_TX_DATA     32
#define PORT_UART_RX_READ     33
#define PORT_UART_TX_WRITE    34
#define PORT_ETH_RX_READ      48

// input ports

#define PORT_IN_PHY_SMI        2
#define PORT_UART_RX_DATA     32
#define PORT_UART_RX_READY    33
#define PORT_UART_TX_READY    34
#define PORT_JIFFIES          44
#define PORT_ETH_RX_DATA      50
#define PORT_ETH_RX_READY     51

int port_read(int p)
{ return (int)(*(volatile unsigned int*)(0x80000000+4*p)); }

void port_write(int p,unsigned int x)
{ (*(volatile unsigned int*)(0x80000000+4*p)) = x; }

void clock_out(int x)
{ port_write(PORT_CLOCK,x); }

void led(int x)
{ port_write(PORT_LED,x); }

void uart_tx_data(int x)
{ port_write(PORT_UART_TX_DATA,x);
  port_write(PORT_UART_TX_WRITE,1);
  port_write(PORT_UART_TX_WRITE,0); }

int uart_tx_ready()
{ return port_read(PORT_UART_TX_READY); }

int uart_rx_data()
{ unsigned int x;
  x = port_read(PORT_UART_RX_DATA);
  port_write(PORT_UART_RX_READ,1);
  port_write(PORT_UART_RX_READ,0);
  return x; }

int uart_rx_ready()
{ return port_read(PORT_UART_RX_READY); }

unsigned int phy_read(int addr)
{ return 0; }

unsigned int get_jiffies()
{ return port_read(PORT_JIFFIES); }
