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

#define CMD_PORT_WRITE               1
#define CMD_PORT_READ                2
#define CMD_ADC_WRITE_REG            3
#define CMD_ADC_READ_REG             4
#define CMD_GLOBAL_WRITE             5
#define CMD_GLOBAL_READ              6
#define CMD_CLOCK_WRITE_REG          7
#define CMD_CLOCK_READ_REG           8
#define CMD_PHY_WRITE_REG            9
#define CMD_PHY_READ_REG            10
#define CMD_FLASH_READ              11
#define CMD_FLASH_WRITE             12
#define CMD_FLASH_ERASE_CONFIG_AREA 13
#define CMD_MAX2112_WRITE_REG       14
#define CMD_MAX2112_READ_REG        15

void process_eth_packet()
{ int cmd;
  unsigned int tag;
  unsigned char addr, val, channel;
  unsigned int w;
  tag = (eth_rx_data(0)<<24) | (eth_rx_data(1)<<16) | (eth_rx_data(2)<<8) | eth_rx_data(3);
  cmd = eth_rx_data(4);
  switch (cmd) {
    case CMD_PORT_WRITE:
      addr = eth_rx_data(5);
      val = eth_rx_data(6);
      port_write(addr,val);
      eth_tx_ack(tag,0);
      break;
    case CMD_PORT_READ:
      addr = eth_rx_data(5);
      val = port_read(addr);
      eth_tx_ack(tag,val);
      break;
    case CMD_ADC_WRITE_REG:
      channel = eth_rx_data(5);
      addr = eth_rx_data(6);
      val = eth_rx_data(7);
      adc_write(channel,addr,val);
      eth_tx_ack(tag,0);
      break;
    case CMD_ADC_READ_REG:
      channel = eth_rx_data(5);
      addr = eth_rx_data(6);
//      val = adc_read(channel,addr);
      eth_tx_ack(tag,val);
      break;
    case CMD_GLOBAL_WRITE:
      break;
    case CMD_GLOBAL_READ:  // gain[] jiffies uart_phy auto_agc
      break;
    case CMD_CLOCK_WRITE_REG:
      addr = eth_rx_data(5);
      w = (eth_rx_data(6)<<24) | (eth_rx_data(7)<<16) | (eth_rx_data(8)<<8) | eth_rx_data(9);
      w = (w&0xffffffe0) | (addr&0x0000001f);
      clock_write(w);
      eth_tx_ack(tag,0);
      break;
    case CMD_CLOCK_READ_REG:
      addr = eth_rx_data(5);
//      w = clock_read(addr);
      eth_tx_ack_word(tag,w);
      break;
    case CMD_PHY_WRITE_REG:
      addr = eth_rx_data(5);
      val = eth_rx_data(6);
      phy_smi_write(addr,val);
      eth_tx_ack(tag,0);
      break;
    case CMD_PHY_READ_REG:
      addr = eth_rx_data(5);
      val = phy_smi_read(addr);
      eth_tx_ack(tag,val);
      break;
    case CMD_FLASH_READ:
      addr = eth_rx_data(5);
      val = spi_read(addr);
      eth_tx_ack(tag,val);
      break;
    case CMD_FLASH_WRITE:
      addr = eth_rx_data(5);
      val = eth_rx_data(6);
//      spi_write(addr,val);
      eth_tx_ack(tag,0);
      break;
    case CMD_FLASH_ERASE_CONFIG_AREA:
//      spi_erase(0x70000);
      eth_tx_ack(tag,0);
      break;
    case CMD_MAX2112_WRITE_REG:
      channel = eth_rx_data(5);
      addr = eth_rx_data(6);
      val = eth_rx_data(7);
      i2c_write(channel,addr,val);
      eth_tx_ack(tag,0);
      break;
    case CMD_MAX2112_READ_REG:
      channel = eth_rx_data(5);
      addr = eth_rx_data(6);
//      val = i2c_read(channel,addr);
      eth_tx_ack(tag,val);
      break; }
  eth_rx_ack(); }
