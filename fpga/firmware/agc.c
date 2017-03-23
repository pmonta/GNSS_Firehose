void set_agc(int channel,int val)
{ int port_base = PORT_OUT_PWM+2*(channel-1);
  if ((channel<1) || (channel>=N_CHANNEL))
    return;
  port_write(port_base,val&0xff);
  port_write(port_base+1,(val>>8)&0x3);
  gain[channel-1] = val; }
