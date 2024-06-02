#
# GNSS Firehose command and control (Ethernet)
#

import socket
import pcapy

class firehose:
  def __init__(self, interface="eth0", mac_addr="00:02:02:03:04:05"):
    self.interface = interface
    self.mac_addr = mac_addr
    self.snaplen = 2048
    self.pc = pcapy.open_live(self.interface, self.snaplen, 1, 1)
    self.pc.setfilter("ether proto 0x88b6 and ether src %s"%mac_addr)
    self.mac_addr_src = b"00:01:02:03:04:06"
    self.ethertype = b"\x88\xb6"
    self.preamble = self.parse_hw_addr(self.mac_addr) + self.parse_hw_addr(self.mac_addr_src) + self.ethertype
    self.s = socket.socket(socket.AF_PACKET, socket.SOCK_RAW)
    self.s.bind((self.interface, 0))

  def sendpacket(self,x):
    self.s.send(x)

  def getpacket(self):
    while True:
      header,packet = self.pc.next()
      if len(packet)!=0:
        break
    return packet

  def parse_hw_addr(self,x):
    s = b''
    for i in range(6):
      b = int(x[3*i:3*i+2],16)
      s = s + bytearray([b])
    return s

  def cmd(self,n,payload=None):
    t = b''
    if payload:
      for i in payload:
        t = t + bytearray([i])
    self.sendpacket(self.preamble+b'\x11\x22\x33\x44'+bytearray([n])+t+b'\x00'*64)
    packet = self.getpacket()
    if n in [8,10]:
      return (packet[18]<<24)|(packet[19]<<16)|(packet[20]<<8)|packet[21]
    else:
      return packet[18]

  def wl(self,w):
    return [(w>>24)&0xff,(w>>16)&0xff,(w>>8)&0xff,w&0xff]

  def port_write(self,addr,val):
    return self.cmd(1,[addr,val])

  def port_read(self,addr):
    return self.cmd(2,[addr])

  def global_read(self,addr):
    return self.cmd(6,[addr])

  def flash_read(self,addr):
    return self.cmd(11,self.wl(addr))

  def flash_write(self,addr,val):
    return self.cmd(12,self.wl(addr)+[val]+[0xbe,0xef])

  def flash_erase(self,addr):
    return self.cmd(13,self.wl(addr)+[0xbe,0xef])

  def max2112_write_reg(self,channel,addr,val):
    return self.cmd(14,[channel,addr,val])

  def max2112_read_reg(self,channel,addr):
    return self.cmd(15,[channel,addr])

  def adc_write_reg(self,channel,addr,val):
    return self.cmd(3,[channel,addr,val])

  def adc_read_reg(self,channel,addr):
    return self.cmd(4,[channel,addr])

  def version(self):
    return self.cmd(16)
