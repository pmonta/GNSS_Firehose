// Ethernet receiver
//
// GNSS Firehose
// Copyright (c) 2015 Peter Monta <pmonta@gmail.com>

module packet_rx(
  input clk,
  input [7:0] data,
  input [1:0] ctl,
  output [7:0] packet_count_rx,
  input cpu_clk,
  input [7:0] cpu_addr,
  output [7:0] cpu_data
);

  reg [7:0] waddr;
  wire we;

  dpram _rx_ram(
    clk, {3'd0,waddr}, data, we,
    cpu_clk, {3'd0,cpu_addr}, cpu_data
  );

  assign we = (ctl==2'b11);

  always @(posedge clk)
    if (ctl==2'b11)
      waddr <= waddr + 1;

endmodule
