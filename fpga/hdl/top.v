// Top-level module, technology-independent
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module top(
  input clk, reset,
  input clk64,

// RF channel 1

  output ch1_sda_t, ch1_scl_t, ch1_gc1,
  input ch1_sda_i, ch1_scl_i,
  output ch1_cs, ch1_sclk,
  input ch1_sdin_i,
  output ch1_sdin_o, ch1_sdin_t,
  input ch1_clk,
  input [15:0] ch1_data,

// RF channel 2

  output ch2_sda_t, ch2_scl_t, ch2_gc1,
  input ch2_sda_i, ch2_scl_i,
  output ch2_cs, ch2_sclk,
  input ch2_sdin_i,
  output ch2_sdin_o, ch2_sdin_t,
  input ch2_clk,
  input [15:0] ch2_data,

// RF channel 3

  output ch3_sda_t, ch3_scl_t, ch3_gc1,
  input ch3_sda_i, ch3_scl_i,
  output ch3_cs, ch3_sclk,
  input ch3_sdin_i,
  output ch3_sdin_o, ch3_sdin_t,
  input ch3_clk,
  input [15:0] ch3_data,

// baseband channel 4

  output ch4_cs, ch4_sclk,
  input ch4_sdin_i,
  output ch4_sdin_o, ch4_sdin_t,
  input ch4_clk,
  input [15:0] ch4_data,

// Ethernet PHY

  input phy_tx_clk,
  output [7:0] phy_tx_mux_data,
  output [1:0] phy_tx_mux_ctl,

  input phy_rx_clk,
  input [7:0] phy_rx_demux_data,
  input [1:0] phy_rx_demux_ctl,

  output phy_mdc,
  input phy_mdio_i,
  output phy_mdio_o, phy_mdio_t,
  input phy_mdint,

// clock chip

  output clock_clk,
  output clock_data,
  output clock_le,
  input clock_readback,
  input clock_ftest_ld,

// debugging UART

  input uart_rx,
  output uart_tx,

// LEDs

  output led0,
  output led1
);

// PWM for gain control pins

  wire [9:0] pwm_ch1, pwm_ch2, pwm_ch3;

  pwm _pwm_ch1(clk, pwm_ch1, ch1_gc1);
  pwm _pwm_ch2(clk, pwm_ch2, ch2_gc1);
  pwm _pwm_ch3(clk, pwm_ch3, ch3_gc1);

// quantizers

  wire [15:0] source_data;
  wire source_en;

  assign source_clk = clk64;
  assign source_reset = reset;

  wire [7:0] ch1_i, ch1_q;
  wire [7:0] ch2_i, ch2_q;
  wire [7:0] ch3_i, ch3_q;
  wire [7:0] ch4_i, ch4_q;

  assign {ch1_i, ch1_q} = {ch1_data[15:8], ch1_data[7:0]};
  assign {ch2_i, ch2_q} = {ch2_data[15:8], ch2_data[7:0]};
  assign {ch3_i, ch3_q} = {ch3_data[15:8], ch3_data[7:0]};
  assign {ch4_i, ch4_q} = {ch4_data[15:8], ch4_data[7:0]};

  wire [1:0] ch1_si, ch1_sq;
  wire [1:0] ch3_si, ch3_sq;

  quantize _quantize_ch1_i(source_clk, ch1_i, ch1_si);
  quantize _quantize_ch1_q(source_clk, ch1_q, ch1_sq);
  quantize _quantize_ch3_i(source_clk, ch3_i, ch3_si);
  quantize _quantize_ch3_q(source_clk, ch3_q, ch3_sq);

  reg [15:0] s_bits;
  reg s_en;

  always @(posedge source_clk) begin
    s_bits <= {s_bits[7:0],ch1_si,ch1_sq,ch3_si,ch3_sq};
    s_en <= ~s_en;
  end

  assign source_data = s_bits;
  assign source_en = s_en;

// Ethernet MAC

  packet_streamer _packet_streamer(
    source_clk, source_reset,
    source_data, source_en,
    phy_tx_clk, phy_tx_mux_data, phy_tx_mux_ctl
  );

// I/O ports for peripherals

  wire [7:0] out_port_0;  // Clock chip serial link
  wire [7:0] out_port_1;  // loopback testing
  wire [7:0] out_port_2;  // LEDs
  wire [7:0] out_port_4;  // Ethernet PHY SMI bus
  wire [7:0] out_port_6;  // pwm, ch1
  wire [7:0] out_port_7;
  wire [7:0] out_port_8;  // pwm, ch2
  wire [7:0] out_port_9;
  wire [7:0] out_port_10;  // pwm, ch3
  wire [7:0] out_port_11;
  wire [7:0] out_port_12;  // SPI, ch1
  wire [7:0] out_port_13;  // SPI, ch2
  wire [7:0] out_port_14;  // SPI, ch3
  wire [7:0] out_port_15;  // SPI, ch4
  wire [7:0] out_port_17;  // I2C, ch1
  wire [7:0] out_port_18;  // I2C, ch2
  wire [7:0] out_port_19;  // I2C, ch3

  assign {clock_clk,clock_data,clock_le} = out_port_0[2:0];
  assign led1 = out_port_2[0];
  assign {phy_mdc,phy_mdio_o,phy_mdio_t} = out_port_4[2:0];
  assign pwm_ch1 = {out_port_7[1:0],out_port_6};
  assign pwm_ch2 = {out_port_9[1:0],out_port_8};
  assign pwm_ch3 = {out_port_11[1:0],out_port_10};
  assign {ch1_cs,ch1_sclk,ch1_sdin_o,ch1_sdin_t} = out_port_12;
  assign {ch2_cs,ch2_sclk,ch2_sdin_o,ch2_sdin_t} = out_port_13;
  assign {ch3_cs,ch3_sclk,ch3_sdin_o,ch3_sdin_t} = out_port_14;
  assign {ch4_cs,ch4_sclk,ch4_sdin_o,ch4_sdin_t} = out_port_15;
  assign {ch1_sda_t,ch1_scl_t} = out_port_17;
  assign {ch2_sda_t,ch2_scl_t} = out_port_18;
  assign {ch3_sda_t,ch3_scl_t} = out_port_19;

  wire [7:0] in_port_0;  // clock chip readback and lock status
  wire [7:0] in_port_1;  // loopback testing
  wire [7:0] in_port_2;  // PHY SMI bus
  wire [7:0] in_port_5;  // I2C and SPI, ch1
  wire [7:0] in_port_6;  // I2C and SPI, ch2
  wire [7:0] in_port_7;  // I2C and SPI, ch3
  wire [7:0] in_port_8;  // SPI, ch4

  assign in_port_0 = {6'd0,clock_readback,clock_ftest_ld};
  assign in_port_1 = out_port_1;
  assign in_port_2 = {6'd0,phy_mdio_i,phy_mdint};
  assign in_port_5 = {ch1_sda_i,ch1_scl_i,ch1_sdin_i};
  assign in_port_6 = {ch2_sda_i,ch2_scl_i,ch2_sdin_i};
  assign in_port_7 = {ch3_sda_i,ch3_scl_i,ch3_sdin_i};
  assign in_port_8 = {ch4_sdin_i};

// housekeeping CPU

  cpu _cpu(clk, reset,
    uart_tx, uart_rx,
    out_port_0, out_port_1, out_port_2, out_port_4, out_port_6, out_port_7,
    out_port_8, out_port_9, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15,
    out_port_17, out_port_18, out_port_19,
    in_port_0, in_port_1, in_port_2, in_port_5, in_port_6, in_port_7, in_port_8
  );

// monitor the lock-detect signal

  activity _activity(clk, clock_ftest_ld, led0);

endmodule

`include "cpu/cpu.v"
`include "cpu/uart.v"
`include "ram.v"
`include "pwm.v"
`include "packet_streamer.v"
`include "crc.v"
`include "activity.v"
`include "quantize.v"
