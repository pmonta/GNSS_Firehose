// Convert a libpcap/tcpdump file to files of 8-bit samples
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

#include <stdio.h>

unsigned char buf[1062];
unsigned long long t0,timestamp,delta;
unsigned char ch_a[1024];
unsigned char ch_b[1024];
unsigned char z[1024];

void convert(unsigned char x[], FILE* fp_a, FILE* fp_b)
{ int i;
  unsigned char x_a_i, x_a_q, x_b_i, x_b_q;
  for (i=0; i<1024; i++) {
    x_a_i = (x[i]>>6)&3;
    x_a_q = (x[i]>>4)&3;
    x_b_i = (x[i]>>2)&3;
    x_b_q = x[i]&3;
    fwrite(&x_a_i,1,1,fp_a);
    fwrite(&x_a_q,1,1,fp_a);
    fwrite(&x_b_i,1,1,fp_b);
    fwrite(&x_b_q,1,1,fp_b); } }

int main()
{ int i,n;
  FILE* fp_a;
  FILE* fp_b;
  for (i=0; i<1024; i++)
    z[i] = 0;
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  fread(buf,4,1,stdin);
  for (i=0; i<100; i++) {
    fread(buf,1062,1,stdin);
    timestamp = (((long long)buf[30])<<56) | (((long long)buf[31])<<48) | (((long long)buf[32])<<40) | (((long long)buf[33])<<32) | (((long long)buf[34])<<24) | (((long long)buf[35])<<16) | (((long long)buf[36])<<8) | (((long long)buf[37])<<0); }
  t0 = timestamp;
  i = 100;
  fp_a = fopen("ch_a.s8","w");
  fp_b = fopen("ch_b.s8","w");
  for (;;) {
    n = fread(buf,1062,1,stdin);
    if (n!=1)
      break;
    timestamp = (((long long)buf[30])<<56) | (((long long)buf[31])<<48) | (((long long)buf[32])<<40) | (((long long)buf[33])<<32) | (((long long)buf[34])<<24) | (((long long)buf[35])<<16) | (((long long)buf[36])<<8) | (((long long)buf[37])<<0);
    delta = timestamp - t0;
    if (delta!=1024)
      fprintf(stderr,"packet %d: timestamp delta %d (%d %d)\n",i,(int)delta,((int)delta)/512,((int)delta)%512);
    if (delta<0) {
      fprintf(stderr,"delta<0, bailing out");
      break; }
    while (delta>1024) {
      fwrite(z,1024,1,fp_a);
      fwrite(z,1024,1,fp_a);
      fwrite(z,1024,1,fp_b);
      fwrite(z,1024,1,fp_b);
      delta -= 1024; }
    convert(&buf[38],fp_a,fp_b);
    i = i + 1;
    t0 = timestamp; }
  return 0; }
