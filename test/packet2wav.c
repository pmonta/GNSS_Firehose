// Convert a libpcap/tcpdump file to files of 8-bit samples
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

#include <stdio.h>
#include <stdlib.h>

unsigned char buf[1062];
unsigned long long t0,timestamp,delta;

void convert(unsigned char x[], int chan)
{ int i;
  unsigned char x_a_i, x_a_q, x_b_i, x_b_q;
  unsigned char buf[2048];
  for (i=0; i<1024; i++) {
    x_a_i = (x[i]>>6)&3;
    x_a_q = (x[i]>>4)&3;
    x_b_i = (x[i]>>2)&3;
    x_b_q = x[i]&3;
    x_a_i = 2*x_a_i - 3;
    x_a_q = 2*x_a_q - 3;
    x_b_i = 2*x_b_i - 3;
    x_b_q = 2*x_b_q - 3;
    buf[2*i] = (chan==1) ? x_a_q : x_b_q;
    buf[2*i+1] = (chan==1) ? x_a_i : x_b_i; }
  fwrite(buf,2048,1,stdout); }

void convert_zeros(int n)
{ unsigned char buf[2048];
  int i;
  for (i=0; i<1024; i++) {
    buf[2*i] = 0;
    buf[2*i+1] = 0; }
  fwrite(buf,2048,1,stdout); }

int read_next_valid_packet()
{ int plen;
  int n;
  for (;;) {
    n = fread(buf,16,1,stdin);
    if (n!=1)
      return 0;
    plen = buf[8] + (buf[9]<<8) + (buf[10]<<16) + (buf[11]<<22);
    fread(buf+16,plen,1,stdin);
    if (plen==0x0416)
      return 1; } }

int main(int argc, char* argv[])
{ int i,n;
  int skip;
  int chan;
  skip = 100;
  chan = 1;
  if (argc==2)
    chan = atoi(argv[1]);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  for (i=0; i<skip; i++) {
    n = read_next_valid_packet();
    timestamp = (((long long)buf[30])<<56) |
                (((long long)buf[31])<<48) |
                (((long long)buf[32])<<40) |
                (((long long)buf[33])<<32) |
                (((long long)buf[34])<<24) |
                (((long long)buf[35])<<16) |
                (((long long)buf[36])<<8) |
                (((long long)buf[37])<<0); }
  t0 = timestamp;
  i = skip;
  for (;;) {
    n = read_next_valid_packet();
    if (n!=1)
      break;
    timestamp = (((long long)buf[30])<<56) |
                (((long long)buf[31])<<48) |
                (((long long)buf[32])<<40) |
                (((long long)buf[33])<<32) |
                (((long long)buf[34])<<24) |
                (((long long)buf[35])<<16) |
                (((long long)buf[36])<<8) |
                (((long long)buf[37])<<0);
    delta = timestamp - t0;
    if (delta!=1024)
      fprintf(stderr,"packet %d: timestamp delta %d (pkt %d rem %d) (ts1 %08llx ts2 %08llx)\n",
                i,(int)delta,((int)delta)/512,((int)delta)%512,t0,timestamp);
    if (delta<0) {
      fprintf(stderr,"delta<0, bailing out");
      break; }
    while (delta>1024) {
      convert_zeros(1024);
      delta -= 1024; }
    convert(&buf[38],chan);
    i = i + 1;
    t0 = timestamp; }
  return 0; }
