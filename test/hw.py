# Interface a high-level hardware API to GPIO reads and writes over the UART.
# Implements bus protocols and programming for clock chip, max2112, max19505, and Micrel PHY.
#
# GNSS Firehose
# Copyright (c) 2012,2014 Peter Monta <pmonta@gmail.com>

import serial
import time

class hw:
  def __init__(self, ttyport="/dev/ttyUSB0"):
    self.ser = serial.Serial(ttyport, 115200, timeout=1)
    self.port = None
    self.sda = {}
    self.scl = {}

  def phex(self, p):
    return '%s%s' % (chr(ord('0')+((p>>4)&15)),chr(ord('0')+(p&15)))

  def swrite(self, s):
    # print 'writing <%s>' % s
    self.ser.write(s)
  def sread(self):
    x = self.ser.read(1)
    # print 'read <0x%02x>' % ord(x)
    return x

  def addr(self, port):
    if port!=self.port:
      self.swrite('%sm' % self.phex(port))
      self.port = port    
  def write(self, port, val):
    self.addr(port)
    self.swrite('%sw' % self.phex(val))
  def read(self, port):
    self.addr(port)
    self.swrite('r')
    x = self.sread()
    return ord(x)
  def read_scratchpad(self, addr):
    self.addr(addr)
    self.swrite('s')
    x = self.sread()
    return ord(x)

  def test(self):
    print '0x%02x' % self.read(31)
    self.write(1,0x56)
    print '0x%02x' % self.read(1)
    self.write(1,0x78)
    print '0x%02x' % self.read(1)
    
  def clock_write_bit(self, x):
    if x==0:
      self.write(0,0)
      self.write(0,4)
      self.write(0,0)
    else:
      self.write(0,2)
      self.write(0,6)
      self.write(0,2)

  def clock_le(self):
    self.write(0,0)
    self.write(0,1)
    self.write(0,0)

  def clock_write(self, addr, val):
    val = (val&0xffffffe0) | (addr&0x0000001f)
    for i in range(32):
      self.clock_write_bit((val>>(31-i))&1)
    self.clock_le()

  def clock_read_bit(self):
    self.write(0,4)
    b = self.read(0)
    b = (b>>1)&1
    self.write(0,0)
    return b

  def clock_read(self, addr):
    self.clock_write(31, addr<<16)
    x = 0
    for i in range(32):
      x = (x<<1) | self.clock_read_bit()
    return x

  def clock_init(self, vco_div, max2112_div, adc_div):
    vals = [
      (0, (1<<31) | (1<<17) | (max2112_div<<5)),
      # R0: clkout0/1 max2112 channel 1,2 reference
      (0, (0<<31) | (max2112_div<<5)),
      (0, (0<<31) | (max2112_div<<5)),
      # R1: clkout2/3 max2112 channel 3 reference
      (1, (0<<31) | (max2112_div<<5)),
      (1, (0<<31) | (max2112_div<<5)),
      # R1: clkout4/5 unused
      (2, (1<<31) | (max2112_div<<5)),
      (2, (1<<31) | (max2112_div<<5)),
      # R3: clkout6/7 fpga
      (3, (0<<31) | (adc_div<<5)),
      (3, (0<<31) | (adc_div<<5)),
      # R4: clkout8/9 max19505 channels 2 and 3
      (4, (0<<31) | (adc_div<<5)),
      (4, (0<<31) | (adc_div<<5)),
      # R4: clkout10/11 max19505 channels 4 and 1
      (5, (0<<31) | (adc_div<<5)),
      (5, (0<<31) | (adc_div<<5)),
      (6, (0<<28) | (0x06<<24) | (0x06<<20) | (0x06<<16)),
      (7, (0<<28) | (0x01<<24) | (0<<20) | (0<<16)),
      (8, (0x01<<28) | (0x01<<24) | (0x01<<20) | (0x01<<16)),
      (9, 0x55555540),
      (10, (1<<28) | (1<<14)),
      (11, 0x34000000 | (0<<20)),
      (12, 0x100c0060 | (3<<24) | (0<<23)),
      (13, 0x3b020660),
      (14, (2<<24)),
      (16, 0xc1550400),
      (24, 0x00000000 | (0<<28) | (0<<24) | (0<<20) | (0<<16)),
      # (26, 0x83a00000 | (0<<29) | (3<<26) | (8192<<6)),
      (26, 0x83a00000 | (0<<29) | (0<<26) | (8192<<6)),
      (28, (1<<20)),
      (29, 0x00800000 | (0<<24) | (vco_div<<5)),
      (30, (2<<24) | (vco_div<<5)),
    ]
    for (addr,val) in vals:
      # print 'writing 0x%08x to address %d' % (val,addr)
      self.clock_write(addr,val)
    time.sleep(0.1)
    self.clock_write(11,0x34010000 | (0<<20))  # generate a SYNC pulse
    time.sleep(0.1)
    self.clock_write(11,0x34000000 | (0<<20))

  def clock_locked(self):
    b = self.read(0)
    return b&1

  def clock_dump_regs(self):
    for addr in range(0,32):
      print '%d:  0x%08x' % (addr,self.clock_read(addr))

  def adc_write_bit(self, channel, x):
    port = 12 + (channel-1)
    if x==0:
      self.write(port,0x01)
      self.write(port,0x05)
      self.write(port,0x01)
    else:
      self.write(port,0x03)
      self.write(port,0x07)
      self.write(port,0x03)

  def adc_read_bit(self, channel):
    wport = 12 + (channel-1)
    self.write(wport,0x00)
    port = 5 + (channel-1)
    b = self.read(port)
    self.write(wport,0x04)
    self.write(wport,0x00)
    return b&1

  def adc_cs(self, channel, x):
    port = 12 + (channel-1)
    if x==0:
      self.write(port,0x01)
    else:
      self.write(port,0x09)

  def adc_read(self, channel, addr):
    self.adc_cs(channel,0)
    self.adc_write_bit(channel,1)
    for i in range(7):
      self.adc_write_bit(channel,(addr>>(6-i))&1)
    x = 0
    for i in range(8):
      x = (x<<1) | self.adc_read_bit(channel)
    self.adc_cs(channel,1)
    return x

  def adc_write(self, channel, addr, val):
    self.adc_cs(channel,0)
    self.adc_write_bit(channel,0)
    for i in range(7):
      self.adc_write_bit(channel,(addr>>(6-i))&1)
    for i in range(8):
      self.adc_write_bit(channel,(val>>(7-i))&1)
    self.adc_cs(channel,1)

  def adc_init(self, channel):
    self.adc_cs(channel,1)
#    for addr in range(9):
#      print 'adc channel %d reg %d:  0x%02x' % (channel,addr,self.adc_read(channel,addr))
    self.adc_write(channel,0,0x03)
    self.adc_write(channel,1,0x1a)
    self.adc_write(channel,3,0x07)  # clock/data delay
    self.adc_write(channel,4,0x1b)  # drive strength A 150 ohms
    self.adc_write(channel,5,0x1b)  # drive strength B 150 ohms
    self.adc_write(channel,6,0x28)  # Gray code
    self.adc_write(channel,8,0x88)
#    for addr in range(9):
#      print 'adc channel %d reg %d:  0x%02x' % (channel,addr,self.adc_read(channel,addr))

  def phy_smi_write_bit(self, x):
    if x==0:
      self.write(4,0x01)
      self.write(4,0x05)
      self.write(4,0x01)
    else:
      self.write(4,0x03)
      self.write(4,0x07)
      self.write(4,0x03)

  def phy_smi_read_bit(self):
    b = self.read(2)
    self.write(4,0x00)
    self.write(4,0x04)
    self.write(4,0x00)
    return (b>>1)&1

  def phy_smi_read(self, addr, phy_addr=0):
    self.phy_smi_write_bit(0)
    self.phy_smi_write_bit(1)
    self.phy_smi_write_bit(1)
    self.phy_smi_write_bit(0)
    for i in range(5):
      self.phy_smi_write_bit((phy_addr>>(4-i))&1)
    for i in range(5):
      self.phy_smi_write_bit((addr>>(4-i))&1)
    self.phy_smi_read_bit()
    self.phy_smi_read_bit()
    x = 0
    for i in range(16):
      x = (x<<1) | self.phy_smi_read_bit()
    return x

  def phy_smi_write(self, addr, val, phy_addr=0):
    self.phy_smi_write_bit(0)
    self.phy_smi_write_bit(1)
    self.phy_smi_write_bit(0)
    self.phy_smi_write_bit(1)
    for i in range(5):
      self.phy_smi_write_bit((phy_addr>>(4-i))&1)
    for i in range(5):
      self.phy_smi_write_bit((addr>>(4-i))&1)
    self.phy_smi_write_bit(1)
    self.phy_smi_write_bit(0)
    for i in range(16):
      self.phy_smi_write_bit((val>>(15-i))&1)

  def phy_smi_write_extended(self, addr, val):
    self.phy_smi_write(31, 1)
    # print '0x%04x' % self.phy_smi_read(addr)
    self.phy_smi_write(addr, val)
    # print '0x%04x' % self.phy_smi_read(addr)
    self.phy_smi_write(31, 0)

  def phy_reset(self):
    self.write(20, 1)
    time.sleep(2)
    self.write(20, 0)
    time.sleep(2)

  def i2c_set(self, channel):
    port = 17 + (channel-1)
    val = 2*self.sda[channel] + self.scl[channel]
    self.write(port, val)

  def i2c_set_sda(self, channel, val):
    self.sda[channel] = val
    self.i2c_set(channel)

  def i2c_get_sda(self, channel):
    port = 5 + (channel-1)
    b = self.read(port)
    return (b>>2)&1

  def i2c_set_scl(self, channel, val):
    self.scl[channel] = val
    self.i2c_set(channel)

  def i2c_get_scl(self, channel):
    port = 5 + (channel-1)
    b = self.read(port)
    return (b>>1)&1

  def i2c_init(self, channel):
    self.sda[channel] = 1
    self.scl[channel] = 1
    self.i2c_set(channel)

  def i2c_start(self, channel):
    self.i2c_set_sda(channel, 0)
    self.i2c_set_scl(channel, 0)

  def i2c_stop(self, channel):
    self.i2c_set_scl(channel, 1)
    self.i2c_set_sda(channel, 1)

  def i2c_bit(self, channel, b):
    self.i2c_set_sda(channel, b)
    self.i2c_set_scl(channel, 1)
    bb = self.i2c_get_sda(channel)
    self.i2c_set_scl(channel, 0)
    if b!=bb:
      print 'i2c conflict'

  def i2c_get_bit(self, channel):
    self.i2c_set_sda(channel, 1)
    self.i2c_set_scl(channel, 1)
    b = self.i2c_get_sda(channel)
    self.i2c_set_scl(channel, 0)
    return b

  def ack(self, channel):
    ack = self.i2c_get_bit(channel)
    # print 'ack',ack

  def nack(self, channel):
    self.i2c_bit(channel, 1)

  def i2c_write(self, channel, addr, val):
    self.i2c_start(channel)
    slave = 0x60
    for i in range(7):
      self.i2c_bit(channel, (slave>>(6-i))&1)
    self.i2c_bit(channel, 0)
    self.ack(channel)
    for i in range(8):
      self.i2c_bit(channel, (addr>>(7-i))&1)
    self.ack(channel)
    for i in range(8):
      self.i2c_bit(channel, (val>>(7-i))&1)
    self.ack(channel)
    self.i2c_stop(channel)

  def i2c_read(self, channel, addr):
    self.i2c_start(channel)
    slave = 0x60
    for i in range(7):
      self.i2c_bit(channel, (slave>>(6-i))&1)
    self.i2c_bit(channel, 0)
    self.ack(channel)
    for i in range(8):
      self.i2c_bit(channel, (addr>>(7-i))&1)
    self.ack(channel)
    self.i2c_set_sda(channel, 1)
    self.i2c_set_scl(channel, 1)
    self.i2c_start(channel)
    slave = 0x60
    for i in range(7):
      self.i2c_bit(channel, (slave>>(6-i))&1)
    self.i2c_bit(channel, 1)
    self.ack(channel)
    x = 0
    for i in range(8):
      x = (x<<1) | self.i2c_get_bit(channel)
    self.nack(channel)
    self.i2c_stop(channel)
    return x

  def max2112_init(self, channel, N):
    self.i2c_init(channel)
    FRAC = 0
    CPLIN = 1
    CPMP = 0
    F = 0
    R = 2
    XD = 0
    ICP = 0
    CPS = 1
    freq = N*34436571   # assume 30 MHz reference frequency for divider selection
    if freq<1125000000:
      D24 = 1
    else:
      D24 = 0
    ADE = 0
    ADL = 0
    VAS = 1
    VCO = 25
    LPF = 92   # 3dB point: 4 MHz + (LPF-12)*0.29MHz == 27.20 MHz
    BBG = 7
    PWDN = 0
    STBY = 0
    LDMUX = 0
    TURBO = 1
    CPTST = 0
    regs = [
      (5, (XD<<5) | R),
      (6, (D24<<7) | (CPS<<6) | (ICP<<5)),
      (7, (VCO<<3) | (VAS<<2) | (ADL<<1) | ADE),
      (8, LPF),
      (9, (STBY<<7) | (PWDN<<5) | BBG),
      (10, 0),
      (11, (CPTST<<5) | (TURBO<<3) | LDMUX),
      (1, (N&0xff)),
      (2, (CPMP<<6) | (CPLIN<<4) | (F>>16)),
      (3, (F>>8)&0xff),
      (4, (F&0xff)),
      (0, (FRAC<<7) | (N>>8)),
    ]
    for (addr,val) in regs:
      # print 'writing %d: 0x%02x' % (addr,val)
      self.i2c_write(channel, addr, val)
    # for addr in range(14):
    #   print '%d: 0x%02x' % (addr,self.i2c_read(channel, addr))
    r12 = self.i2c_read(channel, 12)
    r13 = self.i2c_read(channel, 13)
    print 'channel %d:  0x%02x 0x%02x   locked:%d vco:%d' % (channel,r12,r13,(r12>>4)&1,r13>>3)

  def max2112_dump(self, channel):
    for addr in range(14):
      print '%d: 0x%02x' % (addr,self.i2c_read(channel, addr))

  def histogram_dump(self):
    print 'histograms: ',self.read(20), self.read(21), self.read(22), self.read(23), self.read(24), self.read(25)
    print 'gc values: ',self.read_scratchpad(0), self.read_scratchpad(1), self.read_scratchpad(2), self.read_scratchpad(3), self.read_scratchpad(4), self.read_scratchpad(5)

  def set_agc(self, channel, val):
    msb = (val>>8)&3
    lsb = val&0xff
    port_lsb = 6 + 2*(channel-1)
    port_msb = port_lsb + 1
    self.write(port_msb, msb)
    self.write(port_lsb, lsb)

  def packet_count(self):
    msb = self.read(26)
    lsb = self.read(27)
    return 256*msb + lsb
