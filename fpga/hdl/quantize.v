// Simple 2-bit quantizer
// to be replaced with an AGC scheme later
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module quantize(
  input clk,
  input [7:0] x,
  output reg [1:0] y
);

  always @(posedge clk)
    casex (x)
      8'b00000xxx: y <= 2'b10;
      8'b11111xxx: y <= 2'b01;
      8'b0xxxxxxx: y <= 2'b11;
      default:     y <= 2'b00;
    endcase

endmodule
