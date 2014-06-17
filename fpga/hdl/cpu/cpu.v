// primitive housekeeping "cpu":  bridge UART commands to GPIO ports
// to be replaced at some point with a ZPU or picoblaze
//
// xxm  set address (use 4 LSBs of each 'x' to form byte)
// xxw  write
// r    read (emits a byte)
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module cpu(
  input clk, reset,
  output uart_tx,
  input uart_rx,
  output reg [7:0] out_port_0, out_port_1, out_port_2, out_port_4, out_port_6, out_port_7,
  output reg [7:0] out_port_8, out_port_9, out_port_10, out_port_11, out_port_12, out_port_13, out_port_14, out_port_15,
  output reg [7:0] out_port_17, out_port_18, out_port_19,
  output reg [7:0] out_port_20,
  output reg [7:0] out_port_21,
  input [7:0] in_port_0, in_port_1, in_port_2, in_port_5, in_port_6, in_port_7,
  input [7:0] in_port_8,
  input [7:0] in_port_17, in_port_18, in_port_19,
  input [7:0] in_port_20, in_port_21, in_port_22, in_port_23, in_port_24, in_port_25,
  input [7:0] in_port_26, in_port_27,
  input [7:0] in_port_28, in_port_29, in_port_30, in_port_31
);

  wire baudclk16;

  uart_baud_clock_16x _uart_baud_clock_16x(clk, baudclk16);

  wire [7:0] uart_rx_data;
  wire uart_rx_ready;
  reg uart_rx_read;

  uart_rx _uart_rx(clk, reset, baudclk16, uart_rx, uart_rx_data, uart_rx_ready, uart_rx_read);

  reg [7:0] uart_tx_data;
  wire uart_tx_ready;
  reg uart_tx_write;

  uart_tx _uart_tx(clk, reset, baudclk16, uart_tx, uart_tx_data, uart_tx_ready, uart_tx_write);

// implement input and output ports

  wire [7:0] port_id;

  wire [7:0] in_port = (port_id==8'd0) ? in_port_0 :
                       (port_id==8'd1) ? in_port_1 :
                       (port_id==8'd2) ? in_port_2 :
                       (port_id==8'd5) ? in_port_5 :
                       (port_id==8'd6) ? in_port_6 :
                       (port_id==8'd7) ? in_port_7 :
                       (port_id==8'd8) ? in_port_8 :
                       (port_id==8'd17) ? in_port_17 :
                       (port_id==8'd18) ? in_port_18 :
                       (port_id==8'd19) ? in_port_19 :
                       (port_id==8'd20) ? in_port_20 :
                       (port_id==8'd21) ? in_port_21 :
                       (port_id==8'd22) ? in_port_22 :
                       (port_id==8'd23) ? in_port_23 :
                       (port_id==8'd24) ? in_port_24 :
                       (port_id==8'd25) ? in_port_25 :
                       (port_id==8'd26) ? in_port_26 :
                       (port_id==8'd27) ? in_port_27 :
                       (port_id==8'd28) ? in_port_28 :
                       (port_id==8'd29) ? in_port_29 :
                       (port_id==8'd30) ? in_port_30 :
                       (port_id==8'd31) ? in_port_31 :
                       (port_id==8'd32) ? uart_rx_data :
                       (port_id==8'd33) ? {7'd0,uart_rx_ready} :
                       (port_id==8'd34) ? {7'd0,uart_tx_ready} :
                       8'hff;

  wire read_strobe;
  wire write_strobe;

  wire [7:0] out_port;

  always @(posedge clk)
    if (reset) begin
      out_port_0 <= 0;
      out_port_1 <= 0;
      out_port_2 <= 0;
      out_port_4 <= 0;
      out_port_6 <= 8'h40;
      out_port_7 <= 0;
      out_port_8 <= 8'h40;
      out_port_9 <= 0;
      out_port_10 <= 8'h40;
      out_port_11 <= 0;
      out_port_12 <= 0;
      out_port_13 <= 0;
      out_port_14 <= 0;
      out_port_15 <= 0;
      out_port_17 <= 8'h03;
      out_port_18 <= 8'h03;
      out_port_19 <= 8'h03;
      out_port_20 <= 0;
      out_port_21 <= 0;
      uart_tx_data <= 0;
      uart_rx_read <= 0;
      uart_tx_write <= 0;
    end else begin
      if (write_strobe)
        case (port_id)
          8'd0: out_port_0 <= out_port;
          8'd1: out_port_1 <= out_port;
          8'd2: out_port_2 <= out_port;
          8'd4: out_port_4 <= out_port;
          8'd6: out_port_6 <= out_port;
          8'd7: out_port_7 <= out_port;
          8'd8: out_port_8 <= out_port;
          8'd9: out_port_9 <= out_port;
          8'd10: out_port_10 <= out_port;
          8'd11: out_port_11 <= out_port;
          8'd12: out_port_12 <= out_port;
          8'd13: out_port_13 <= out_port;
          8'd14: out_port_14 <= out_port;
          8'd15: out_port_15 <= out_port;
          8'd17: out_port_17 <= out_port;
          8'd18: out_port_18 <= out_port;
          8'd19: out_port_19 <= out_port;
          8'd20: out_port_20 <= out_port;
          8'd21: out_port_21 <= out_port;
          8'd32: uart_tx_data <= out_port;
          8'd33: uart_rx_read <= out_port[0];
          8'd34: uart_tx_write <= out_port[0];
        endcase
    end

  wire [9:0] address;
  wire [17:0] instruction;
  wire interrupt = 0;
  wire interrupt_ack;

  cpu_rom _cpu_rom(address, instruction, clk);

  pacoblaze _pacoblaze(
    address, instruction,
    port_id,
    write_strobe, out_port,
    read_strobe, in_port,
    interrupt,
    interrupt_ack,
    reset, clk
  );

endmodule

//
// baud clock generator
//

module uart_baud_clock_16x(
  input clk,
  output baudclk16
);

  reg [5:0] c;
//  wire m = (c==6'd33);
  wire m = (c==6'd26);

  always @(posedge clk)
    c <= m ? 0 : c+1;

  assign baudclk16 = m;

endmodule
