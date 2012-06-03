// Read a libpcap/tcpdump file and compute a histogram for use with AGC
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

#include <stdio.h>
#include <stdlib.h>

unsigned char buf[1062];
unsigned long long t0,timestamp,delta;
unsigned char ch_a[1024];
unsigned char ch_b[1024];
unsigned long hist_a_i[4];
unsigned long hist_a_q[4];
unsigned long hist_b_i[4];
unsigned long hist_b_q[4];

void count(unsigned char x[])
{ int i;
  unsigned char x_a_i, x_a_q, x_b_i, x_b_q;
  for (i=0; i<1024; i++) {
    x_a_i = (x[i]>>6)&3;
    x_a_q = (x[i]>>4)&3;
    x_b_i = (x[i]>>2)&3;
    x_b_q = x[i]&3;
    hist_a_i[x_a_i]++;
    hist_a_q[x_a_q]++;
    hist_b_i[x_b_i]++;
    hist_b_q[x_b_q]++; } }

int main(int argc, char* argv[])
{ int n;
  int channel = atoi(argv[1]);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  for (;;) {
    n = fread(buf,1062,1,stdin);
    if (n!=1)
      break;
    count(&buf[38]); }
  if (channel==0)
    printf("%ld %ld %ld %ld     %ld %ld %ld %ld\n",hist_a_i[0],hist_a_i[1],hist_a_i[2],hist_a_i[3],hist_a_q[0],hist_a_q[1],hist_a_q[2],hist_a_q[3]);
  else
    printf("%ld %ld %ld %ld     %ld %ld %ld %ld\n",hist_b_i[0],hist_b_i[1],hist_b_i[2],hist_b_i[3],hist_b_q[0],hist_b_q[1],hist_b_q[2],hist_b_q[3]);
  return 0; }
