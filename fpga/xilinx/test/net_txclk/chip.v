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
  output phy_nreset,

  output led0,
  output led1

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

// synthesize Ethernet PHY transmit clock (125 MHz) from clk_tcxo

  wire clk125;
  wire clk125_dcm;
  wire dcm_rst, dcm_locked;

  DCM_CLKGEN #(.CLKFX_MULTIPLY(254),.CLKFX_DIVIDE(79)) _dcm_clk125(
    .CLKIN(clk_tcxo),
    .CLKFX(clk125_dcm),
    .RST(dcm_rst),
    .LOCKED(dcm_locked)
  );

  BUFG _bufg_clk125(.I(clk125_dcm), .O(clk125));

// multiplex PHY TX signals

  wire phy_tx_mux_clk = clk125;
  wire [7:0] phy_tx_mux_data;
  wire [1:0] phy_tx_mux_ctl;

  mux_tx _mux_tx(phy_tx_mux_clk, phy_tx_data, phy_tx_mux_data, phy_tx_ctl, phy_tx_mux_ctl);
  mux_tx_clk _mux_tx_clk(phy_tx_mux_clk, phy_tx_clk);

  reg [26:0] pc;
  reg ctl;
  always @(posedge phy_tx_mux_clk) begin
    pc <= pc + 1;
    ctl <= pc[26:19]==8'd0;
  end
  assign phy_tx_mux_data = 0;
  assign phy_tx_mux_ctl = {2{ctl}};

  assign led0 = dcm_locked;
  assign led1 = 1;

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

module mux_tx_clk(
  input clk,
  output clk_forward
);

  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_clk(.D0(1'b1), .D1(1'b0), .C0(clk), .C1(!clk), .CE(1'b1), .Q(clk_forward), .R(1'b0), .S(1'b0));

endmodule

module mux_tx(
  input clk,
  output [3:0] tx_data,
  input [7:0] tx_data_mux,
  output tx_ctl,
  input [1:0] tx_ctl_mux
);

  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_0(.D0(tx_data_mux[0]), .D1(tx_data_mux[4]), .C0(clk), .C1(!clk), .CE(1'b1), .Q(tx_data[0]), .R(1'b0), .S(1'b0));
  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_1(.D0(tx_data_mux[1]), .D1(tx_data_mux[5]), .C0(clk), .C1(!clk), .CE(1'b1), .Q(tx_data[1]), .R(1'b0), .S(1'b0));
  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_2(.D0(tx_data_mux[2]), .D1(tx_data_mux[6]), .C0(clk), .C1(!clk), .CE(1'b1), .Q(tx_data[2]), .R(1'b0), .S(1'b0));
  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_3(.D0(tx_data_mux[3]), .D1(tx_data_mux[7]), .C0(clk), .C1(!clk), .CE(1'b1), .Q(tx_data[3]), .R(1'b0), .S(1'b0));
  ODDR2 #(.DDR_ALIGNMENT("C0"),.SRTYPE("ASYNC")) _oddr2_4(.D0(tx_ctl_mux[0]), .D1(tx_ctl_mux[1]), .C0(clk), .C1(!clk), .CE(1'b1), .Q(tx_ctl), .R(1'b0), .S(1'b0));

endmodule
