// Chip-level module, for testing: blink LEDs
//
// GNSS Firehose
// Copyright (c) 2015 Peter Monta <pmonta@gmail.com>

module chip(
  input clk_3888,
  output led0,
  output led1
);

  wire clk_tcxo;
  wire clk_tcxo_i;
  IBUFG _ibuf_clk_3888(.I(clk_3888), .O(clk_tcxo_i));
  BUFG _bufg_clk_tcxo(.I(clk_tcxo_i), .O(clk_tcxo));

  reg [25:0] c;
  always @(posedge clk_tcxo)
    c <= c + 1;

  assign {led1,led0} = c[25:24];

endmodule
