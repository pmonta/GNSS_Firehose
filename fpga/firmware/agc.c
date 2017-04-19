void set_agc(int channel,int val)
{ int port_base = PORT_OUT_PWM+2*(channel-1);
  if ((channel<1) || (channel>N_CHANNEL))
    return;
  port_write(port_base,val&0xff);
  port_write(port_base+1,(val>>8)&0x3);
  gain[channel-1] = val; }

int hist_measure(int channel)
{ int port = PORT_HIST + 2*(channel-1);
  int metric;
  int hist_low_ampl,hist_high_ampl;
  if ((channel<1) || (channel>N_CHANNEL))
    return 0;
  hist_low_ampl = port_read(port);
  hist_high_ampl = port_read(port+1);
  metric = hist_low_ampl - 2*hist_high_ampl;
  if (metric>0)
    return 0;          // signal too weak
  else
    return 1; }        // signal too strong

void agc_service()
{ int channel;
  int g,h;
  if (!agc_enable)
    return;
  for (channel=1; channel<=3; channel++) {
    g = gain[channel-1];
    h = hist_measure(channel);
    if (h)
      g = (g<0x3ff) ? g+1 : g;
    else
      g = (g>0) ? g-1 : g;
    set_agc(channel,g); } }
