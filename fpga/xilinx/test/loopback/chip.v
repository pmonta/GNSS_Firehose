// Chip-level module with technology-specific clock, tristate, DDR handling
//
// GNSS Firehose
// Copyright (c) 2012 Peter Monta <pmonta@gmail.com>

module chip(
  input clk_3888,

// Ethernet PHY (RGMII)

  output phy_tx_clk,
  output [3:0] phy_tx_data,
  output phy_tx_ctl,

  input phy_rx_clk,
  input [3:0] phy_rx_data,
  input phy_rx_ctl,

  output phy_mdc,
  inout phy_mdio,
  input phy_mdint,
  output phy_nreset

);
  
// clocks

  wire clk_tcxo;
  wire clk_tcxo_i;
  IBUFG _ibuf_clk_3888(.I(clk_3888), .O(clk_tcxo_i));
  BUFG _bufg_clk_tcxo(.I(clk_tcxo_i), .O(clk_tcxo));

// MDIO/SMI pins

  assign phy_mdio = 1'bz;
  assign phy_mdc = 1'b1;

// generate reset signals

  wire clk_tcxo_reset;
  reset_gen _reset_gen_clk_tcxo(clk_tcxo, clk_tcxo_reset);

  wire phy_reset;
  wire phy_reset_auto;
  phy_reset_auto _phy_reset_auto(clk_tcxo, clk_tcxo_reset, phy_reset_auto);
  assign phy_nreset = (phy_reset|phy_reset_auto) ? 0 : 1'bz;

  assign phy_tx_clk = phy_rx_clk;
  assign phy_tx_data = phy_rx_data;
  assign phy_tx_ctl = phy_rx_ctl;

endmodule

module phy_reset_auto(
  input clk,
  input reset,
  output reg phy_reset_auto
);

  reg [23:0] c;

  always @(posedge clk)
    if (reset) begin
      c <= 0;
      phy_reset_auto <= 1;
    end else begin
      c <= (c==24'd16777215) ? c : c+1;
      phy_reset_auto <= (c<24'd16000000);
    end

endmodule

module reset_gen(
  input clk,
  output reset
);

  reg [3:0] t = 0;

  always @(posedge clk)
    t <= {t[2:0],1'b1};

  assign reset = !t[3];

endmodule
