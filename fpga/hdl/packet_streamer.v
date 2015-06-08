// Buffer and Ethernet MAC
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module packet_streamer(
  input clk, reset,
  input [15:0] source_data,
  input source_en,
  input tx_clk,
  output reg [7:0] tx_data,
  output reg [1:0] tx_ctl,
  output reg [15:0] packet_count,
  input streamer_enable
);

  reg [9:0] waddr;
  wire flag = waddr[9];
  wire wen0, wen1;

  reg [9:0] raddr;
  wire [7:0] data0, data1;

// ping-pong buffers

  dpram_9_16 _ram0(
    clk, waddr[8:0], source_data, wen0,
    tx_clk, raddr, data0
  );

  dpram_9_16 _ram1(
    clk, waddr[8:0], source_data, wen1,
    tx_clk, raddr, data1
  );

// ADC cycle counter

  reg [63:0] c;
  always @(posedge clk)
    c <= c+1;

// write source data to the two ping-ponged RAMs

  reg [63:0] ticks;

  always @(posedge clk)
    if (reset) begin
      waddr <= 0;
      ticks <= 0;
    end else begin
      if (source_en) begin
        waddr <= waddr+1;
        if (waddr[8:0]==9'd8)
          ticks <= c;
      end
    end

  assign wen0 = source_en && !flag;
  assign wen1 = source_en && flag;

// read from RAMs, construct Ethernet frames

  reg crc_reset, crc_en;
  wire [31:0] crc;

  crc _crc(tx_clk, crc_reset, crc_en, tx_data, crc);

  localparam [5:0]
    IDLE = 6'd0,
    PREAMBLE_0 = 6'd1,
    PREAMBLE_1 = 6'd2,
    PREAMBLE_2 = 6'd3,
    PREAMBLE_3 = 6'd4,
    PREAMBLE_4 = 6'd5,
    PREAMBLE_5 = 6'd6,
    PREAMBLE_6 = 6'd7,
    PREAMBLE_7 = 6'd8,
    DEST_0 = 6'd9,
    DEST_1 = 6'd10,
    DEST_2 = 6'd11,
    DEST_3 = 6'd12,
    DEST_4 = 6'd13,
    DEST_5 = 6'd14,
    SRC_0 = 6'd15,
    SRC_1 = 6'd16,
    SRC_2 = 6'd17,
    SRC_3 = 6'd18,
    SRC_4 = 6'd19,
    SRC_5 = 6'd20,
    TYPELEN_0 = 6'd21,
    TYPELEN_1 = 6'd22,
    TICKS_0 = 6'd23,
    TICKS_1 = 6'd24,
    TICKS_2 = 6'd25,
    TICKS_3 = 6'd26,
    TICKS_4 = 6'd27,
    TICKS_5 = 6'd28,
    TICKS_6 = 6'd29,
    TICKS_7 = 6'd30,
    PAYLOAD = 6'd31,
    FCS_0 = 6'd32,
    FCS_1 = 6'd33,
    FCS_2 = 6'd34,
    FCS_3 = 6'd35;

  reg [5:0] state;
  reg flag_1, flag_2;
  reg [23:0] t;
  reg [63:0] pticks;
//  reg [15:0] d;

  wire tx_clk_reset;
  reset_gen _reset(tx_clk, tx_clk_reset);

  always @(posedge tx_clk)
    if (tx_clk_reset) begin
      flag_1 <= 0;
      flag_2 <= 0;
      tx_ctl <= 2'b00;
      crc_en <= 0;
      crc_reset <= 1;
      state <= IDLE;
      packet_count <= 0;
//      d <= 0;
    end else begin
      flag_1 <= flag;
      flag_2 <= flag_1;
      case (state)
        IDLE:
//          if ((flag_1 ^ flag_2)  && (d==16'h0007) && streamer_enable) begin
          if ((flag_1 ^ flag_2)  && streamer_enable) begin
            state <= PREAMBLE_0;
            crc_reset <= 1;
            pticks <= ticks;
            packet_count <= packet_count + 1;
//            d <= 0;
            tx_ctl <= 2'b00;
//          end else if (flag_1 ^ flag_2) begin
//            d <= d + 1;
//            tx_ctl <= 2'b00;
          end else
            tx_ctl <= 2'b00;
        PREAMBLE_0: begin tx_data <= 8'h55; tx_ctl <= 2'b11; state <= PREAMBLE_1; end
        PREAMBLE_1: begin tx_data <= 8'h55; state <= PREAMBLE_2; end
        PREAMBLE_2: begin tx_data <= 8'h55; state <= PREAMBLE_3; end
        PREAMBLE_3: begin tx_data <= 8'h55; state <= PREAMBLE_4; end
        PREAMBLE_4: begin tx_data <= 8'h55; state <= PREAMBLE_5; end
        PREAMBLE_5: begin tx_data <= 8'h55; state <= PREAMBLE_6; end
        PREAMBLE_6: begin tx_data <= 8'h55; state <= PREAMBLE_7; end
        PREAMBLE_7: begin tx_data <= 8'hd5; state <= DEST_0; end
        DEST_0: begin crc_reset <= 0; crc_en <= 1; tx_data <= 8'hff; state <= DEST_1; end
        DEST_1: begin tx_data <= 8'hff; state <= DEST_2; end
        DEST_2: begin tx_data <= 8'hff; state <= DEST_3; end
        DEST_3: begin tx_data <= 8'hff; state <= DEST_4; end
        DEST_4: begin tx_data <= 8'hff; state <= DEST_5; end
        DEST_5: begin tx_data <= 8'hff; state <= SRC_0; end
        SRC_0: begin tx_data <= 8'h00; state <= SRC_1; end
        SRC_1: begin tx_data <= 8'h01; state <= SRC_2; end
        SRC_2: begin tx_data <= 8'h02; state <= SRC_3; end
        SRC_3: begin tx_data <= 8'h03; state <= SRC_4; end
        SRC_4: begin tx_data <= 8'h04; state <= SRC_5; end
        SRC_5: begin tx_data <= 8'h09; state <= TYPELEN_0; end
        TYPELEN_0: begin tx_data <= 8'h98; state <= TYPELEN_1; end  // Ethernet protocol 0x9800 --- random unused value
        TYPELEN_1: begin tx_data <= 8'h00; state <= TICKS_0; end
        TICKS_0: begin tx_data <= pticks[63:56]; state <= TICKS_1; end
        TICKS_1: begin tx_data <= pticks[55:48]; state <= TICKS_2; end
        TICKS_2: begin tx_data <= pticks[47:40]; state <= TICKS_3; end
        TICKS_3: begin tx_data <= pticks[39:32]; state <= TICKS_4; end
        TICKS_4: begin tx_data <= pticks[31:24]; state <= TICKS_5; end
        TICKS_5: begin tx_data <= pticks[23:16]; state <= TICKS_6; end
        TICKS_6: begin tx_data <= pticks[15:8]; raddr <= 0; state <= TICKS_7; end
        TICKS_7: begin tx_data <= pticks[7:0]; raddr <= 1; state <= PAYLOAD; end
        PAYLOAD:
          begin
            tx_data <= flag ? data0 : data1;
            raddr <= raddr+1;
            if (raddr==10'd0)
              state <= FCS_0;
          end
        FCS_0: begin crc_en <= 0; tx_data <= crc[31:24]; t <= crc[23:0]; state <= FCS_1; end
        FCS_1: begin tx_data <= t[23:16]; state <= FCS_2; end
        FCS_2: begin tx_data <= t[15:8]; state <= FCS_3; end
        FCS_3: begin tx_data <= t[7:0]; state <= IDLE; end
//fixme: add IPG wait states, which will be needed when arbiter is added at IDLE state
      endcase
    end

endmodule
