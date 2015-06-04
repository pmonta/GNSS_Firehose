// Chip-level module, for testing: blink LEDs
//
// GNSS Firehose
// Copyright (c) 2015 Peter Monta <pmonta@gmail.com>

module chip(
  output led0,
  output led1
);

  wire clk;

  STARTUP_SPARTAN6 _startup(
    .CFGMCLK(clk)
  );

  reg [25:0] c;
  always @(posedge clk)
    c <= c + 1;

  assign {led1,led0} = c[25:24];

endmodule
