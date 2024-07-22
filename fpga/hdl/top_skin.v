// Ultra-stupid layer to define clock domains of signals coming in and out of top
// See cdc_snitch.mk
module top_skin(
  input clk_cpu, clk_cpu_reset,
  input clk_adc,

// RF channel 1

  output ch1_sda_t, ch1_scl_t, ch1_gc1,
  input ch1_sda_i, ch1_scl_i,
  output ch1_cs, ch1_sclk,
  input ch1_sdin_i,
  output ch1_sdin_o, ch1_sdin_t,
  input ch1_clk,
  input [15:0] ch1_data,

// RF channel 2

  output ch2_sda_t, ch2_scl_t, ch2_gc1,
  input ch2_sda_i, ch2_scl_i,
  output ch2_cs, ch2_sclk,
  input ch2_sdin_i,
  output ch2_sdin_o, ch2_sdin_t,
  input ch2_clk,
  input [15:0] ch2_data,

// RF channel 3

  output ch3_sda_t, ch3_scl_t, ch3_gc1,
  input ch3_sda_i, ch3_scl_i,
  output ch3_cs, ch3_sclk,
  input ch3_sdin_i,
  output ch3_sdin_o, ch3_sdin_t,
  input ch3_clk,
  input [15:0] ch3_data,

// baseband channel 4

  output ch4_cs, ch4_sclk,
  input ch4_sdin_i,
  output ch4_sdin_o, ch4_sdin_t,
  input ch4_clk,
  input [15:0] ch4_data,

// Ethernet PHY

  input phy_tx_clk,
  output [7:0] phy_tx_mux_data,
  output [1:0] phy_tx_mux_ctl,

  input phy_rx_clk,
  input [7:0] phy_rx_demux_data,
  input [1:0] phy_rx_demux_ctl,

  output phy_mdc,
  input phy_mdio_i,
  output phy_mdio_o, phy_mdio_t,
  input phy_mdint,
  output phy_reset,

// clock chip

  output clock_clk,
  output clock_data,
  output clock_le,
  input clock_readback,
  input clock_ftest_ld,

// debugging UART

  input uart_rx,
  output uart_tx,

// LEDs

  output led0,
  output led1,

// SPI access to flash chip

  output spi_cclk,
  input spi_din,
  output spi_mosi,
  output spi_cso_b,

// DCM control and status

  output dcm_rst,
  input dcm_locked
);

(* magic_cdc *) reg [15:0] ch1_data_r=0, ch2_data_r=0, ch3_data_r=0, ch4_data_r=0;
always @(posedge clk_adc) begin
	ch1_data_r <= ch1_data;
	ch2_data_r <= ch2_data;
	ch3_data_r <= ch3_data;
	ch4_data_r <= ch4_data;
end

(* magic_cdc *) reg clk_cpu_reset_r=0;
always @(posedge clk_cpu) begin
	clk_cpu_reset_r <= clk_cpu_reset;
end

// ETH PHY Rx
(* magic_cdc *) reg [7:0] phy_rx_demux_data_r=0;
(* magic_cdc *) reg [1:0] phy_rx_demux_ctl_r=0;
always @(posedge phy_rx_clk) begin
	phy_rx_demux_data_r <= phy_rx_demux_data;
	phy_rx_demux_ctl_r <= phy_rx_demux_ctl;
end

// ETH PHY Tx
wire [7:0] phy_tx_mux_data_w;
wire [1:0] phy_tx_mux_ctl_w;
reg [7:0] phy_tx_mux_data_r=0;
reg [1:0] phy_tx_mux_ctl_r=0;
always @(posedge phy_tx_clk) begin
	phy_tx_mux_data_r <= phy_tx_mux_data_w;
	phy_tx_mux_ctl_r <= phy_tx_mux_ctl_w;
end
assign phy_tx_mux_data = phy_tx_mux_data_r;
assign phy_tx_mux_ctl = phy_tx_mux_ctl_r;

top _top(
	.clk_cpu(clk_cpu),
	.clk_cpu_reset(clk_cpu_reset_r),
	.clk_adc(clk_adc),
	//
	.ch1_sda_t(ch1_sda_t),
	.ch1_scl_t(ch1_scl_t),
	.ch1_gc1(ch1_gc1),
	.ch1_sda_i(ch1_sda_i),
	.ch1_scl_i(ch1_scl_i),
	.ch1_cs(ch1_cs),
	.ch1_sclk(ch1_sclk),
	.ch1_sdin_i(ch1_sdin_i),
	.ch1_sdin_o(ch1_sdin_o),
	.ch1_sdin_t(ch1_sdin_t),
	.ch1_clk(ch1_clk),
	.ch1_data(ch1_data_r),
	//
	.ch2_sda_t(ch2_sda_t),
	.ch2_scl_t(ch2_scl_t),
	.ch2_gc1(ch2_gc1),
	.ch2_sda_i(ch2_sda_i),
	.ch2_scl_i(ch2_scl_i),
	.ch2_cs(ch2_cs),
	.ch2_sclk(ch2_sclk),
	.ch2_sdin_i(ch2_sdin_i),
	.ch2_sdin_o(ch2_sdin_o),
	.ch2_sdin_t(ch2_sdin_t),
	.ch2_clk(ch2_clk),
	.ch2_data(ch2_data_r),
	//
	.ch3_sda_t(ch3_sda_t),
	.ch3_scl_t(ch3_scl_t),
	.ch3_gc1(ch3_gc1),
	.ch3_sda_i(ch3_sda_i),
	.ch3_scl_i(ch3_scl_i),
	.ch3_cs(ch3_cs),
	.ch3_sclk(ch3_sclk),
	.ch3_sdin_i(ch3_sdin_i),
	.ch3_sdin_o(ch3_sdin_o),
	.ch3_sdin_t(ch3_sdin_t),
	.ch3_clk(ch3_clk),
	.ch3_data(ch3_data_r),
	//
	.ch4_cs(ch4_cs),
	.ch4_sclk(ch4_sclk),
	.ch4_sdin_i(ch4_sdin_i),
	.ch4_sdin_o(ch4_sdin_o),
	.ch4_sdin_t(ch4_sdin_t),
	.ch4_clk(ch4_clk),
	.ch4_data(ch4_data_r),
	//
	.phy_tx_clk(phy_tx_clk),
	.phy_tx_mux_data(phy_tx_mux_data_w),
	.phy_tx_mux_ctl(phy_tx_mux_ctl_w),
	.phy_rx_clk(phy_rx_clk),
	.phy_rx_demux_data(phy_rx_demux_data_r),
	.phy_rx_demux_ctl(phy_rx_demux_ctl_r),
	.phy_mdc(phy_mdc),
	.phy_mdio_i(phy_mdio_i),
	.phy_mdio_o(phy_mdio_o),
	.phy_mdio_t(phy_mdio_t),
	.phy_mdint(phy_mdint),
	.phy_reset(phy_reset),
	//
	.clock_clk(clock_clk),
	.clock_data(clock_data),
	.clock_le(clock_le),
	.clock_readback(clock_readback),
	.clock_ftest_ld(clock_ftest_ld),
	.uart_rx(uart_rx),
	.uart_tx(uart_tx),
	.led0(led0),
	.led1(led1),
	//
	.spi_cclk(spi_cclk),
	.spi_din(spi_din),
	.spi_mosi(spi_mosi),
	.spi_cso_b(spi_cso_b),
	.dcm_rst(dcm_rst),
	.dcm_locked(dcm_locked)
);

endmodule
