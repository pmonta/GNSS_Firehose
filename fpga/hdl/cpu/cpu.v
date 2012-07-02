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
  input [7:0] in_port_0, in_port_1, in_port_2, in_port_5, in_port_6, in_port_7,
  input [7:0] in_port_8
);

  wire baudclk16;

  uart_baud_clock_16x _uart_baud_clock_16x(clk, baudclk16);

  wire [7:0] uart_rx_data;
  wire uart_rx_ready;
  wire uart_rx_read;

  uart_rx _uart_rx(clk, reset, baudclk16, uart_rx, uart_rx_data, uart_rx_ready, uart_rx_read);

  wire [7:0] uart_tx_data;
  wire uart_tx_ready;
  wire uart_tx_write;

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
                       8'hff;

  wire read_strobe;

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
        endcase
    end

  uart_picobus_bridge _uart_picobus_bridge(
    clk, reset,
    uart_rx_data, uart_rx_ready, uart_rx_read,
    uart_tx_data, uart_tx_ready, uart_tx_write,
    port_id,
    out_port, write_strobe,
    in_port, read_strobe
  );

endmodule

//
// baud clock generator
//

module uart_baud_clock_16x(
  input clk,
  output baudclk16
);

  reg [4:0] c;
  wire m = (c==5'd16);

  always @(posedge clk)
    c <= m ? 0 : c+1;

  assign baudclk16 = m;

endmodule

//
// interpret UART commands
//

module uart_picobus_bridge(
  input clk, reset,

  input [7:0] uart_rx_data,
  input uart_rx_ready,
  output uart_rx_read,
  output reg [7:0] uart_tx_data,
  input uart_tx_ready,
  output reg uart_tx_write,

  output reg [7:0] port_id,
  output reg [7:0] out_port,
  output reg write_strobe,
  input [7:0] in_port,
  output reg read_strobe
);

  localparam
    WAIT = 1'd0,
    WRITE = 1'd1;

  reg state;
  reg [7:0] x;
  reg [7:0] t;

  assign uart_rx_read = uart_rx_ready;

  always @(posedge clk)
    if (reset) begin
      uart_tx_write <= 0;
      port_id <= 0;
      out_port <= 0;
      write_strobe <= 0;
      read_strobe <= 0;
    end else begin
      uart_tx_write <= 0;
      write_strobe <= 0;
      read_strobe <= 0;
      case (state)
        WAIT:
          if (uart_rx_ready) begin
            if (uart_rx_data==8'h6d)                   // 'm'
              port_id <= x;
            else if (uart_rx_data==8'h77) begin        // 'w'
              out_port <= x;
              write_strobe <= 1;
            end else if (uart_rx_data==8'h72) begin    // 'r'
              t <= in_port;
              read_strobe <= 1;
              state <= WRITE;
            end else if (uart_rx_data==8'h78) begin    // 'x'
              t <= port_id;
              state <= WRITE;
            end else
              x <= {x[3:0],uart_rx_data[3:0]};
          end
        WRITE:
          begin
            uart_tx_data <= t;
            if (uart_tx_ready) begin
              uart_tx_write <= 1;
              state <= WAIT;
            end
          end
      endcase
    end

endmodule
