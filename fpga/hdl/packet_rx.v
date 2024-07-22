// Ethernet receiver
//
// GNSS Firehose
// Copyright (c) 2015 Peter Monta <pmonta@gmail.com>

module packet_rx(
  input clk,
  input [7:0] data,
  input [1:0] ctl,
  input [47:0] mac_addr,
  output reg [5:0] eth_rx_addr,
  output [7:0] eth_rx_wdata,
  output reg eth_rx_we,
  output reg eth_rx_ready,
  input eth_rx_read
);

  localparam [3:0]
    IDLE = 4'd0,
    PREAMBLE = 4'd1,
    DEST_1 = 4'd2,
    DEST_2 = 4'd3,
    DEST_3 = 4'd4,
    DEST_4 = 4'd5,
    DEST_5 = 4'd6,
    DEST_6 = 4'd7,
    SKIP = 4'd8,
    PAYLOAD = 4'd9,
    WAIT = 4'd10,
    IGNORE = 4'd11;

  reg [3:0] state=0;
  reg [3:0] c=0;
  initial eth_rx_we=0;
  initial eth_rx_ready=0;

  // Pipeline the comparisons used in the pattern match states
  reg mm0=0, mm1=0, mm2=0, mm3=0, mm4=0, mm5=0, mm6=0, pv=0;
  always @(posedge clk) begin
    mm0 <= data==8'hd5;
    mm1 <= data==mac_addr[47:40];
    mm2 <= data==mac_addr[39:32];
    mm3 <= data==mac_addr[31:24];
    mm4 <= data==mac_addr[23:16];
    mm5 <= data==mac_addr[15:8];
    mm6 <= data==mac_addr[7:0];
    pv <= ctl==2'b11;
  end

  assign eth_rx_wdata = data;

  always @(posedge clk)
    case (state)
      IDLE: if (pv) state <= PREAMBLE;
      PREAMBLE: if (~pv) state <= IDLE; else if (mm0) state <= DEST_1;
      DEST_1: if (~pv) state <= IDLE; else if (mm1) state <= DEST_2; else state <= IGNORE;
      DEST_2: if (~pv) state <= IDLE; else if (mm2) state <= DEST_3; else state <= IGNORE;
      DEST_3: if (~pv) state <= IDLE; else if (mm3) state <= DEST_4; else state <= IGNORE;
      DEST_4: if (~pv) state <= IDLE; else if (mm4) state <= DEST_5; else state <= IGNORE;
      DEST_5: if (~pv) state <= IDLE; else if (mm5) state <= DEST_6; else state <= IGNORE;
      DEST_6: if (~pv) state <= IDLE; else if (mm6) begin c <= 0; state <= SKIP; end else state <= IGNORE;
      SKIP:                        // skip over source MAC address and type/len field to get to start of payload
        if (~pv || (ctl!=2'b11))  // might be right
          state <= IDLE;
        else begin
          c <= c + 1;
          if (c==4'd6) begin
            eth_rx_addr <= 0;
            eth_rx_we <= 1;
            state <= PAYLOAD;
          end
        end
      PAYLOAD:                     // place first 64 bytes of payload into packet RAM
        if (ctl!=2'b11)
          state <= IDLE;
        else if (eth_rx_addr==6'd63) begin 
          eth_rx_we <= 0;
          eth_rx_ready <= 1;
          state <= WAIT;
        end else begin
          eth_rx_addr <= eth_rx_addr + 1;
        end
      WAIT: if (eth_rx_read) begin eth_rx_ready <= 0; state <= IDLE; end
      IGNORE: if (ctl!=2'b11) state <= IDLE;
      default: state <= IDLE;
    endcase

endmodule
