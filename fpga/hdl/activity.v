// Monitor any transitions, stretch the pulse so it's human-visible
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module activity(
  input clk,
  input x,
  output reg led
);

  reg x0=0, x1=0;
  reg [23:0] c=0;

  always @(posedge clk) begin
    x0 <= x;  // define clock domain, possibly with input cell
    x1 <= x0;
    if (x0^x1)
      c <= 0;
    else
      c <= (c==24'd16777215) ? c : c+1;
    led <= (c!=24'd16777215);
  end


endmodule
