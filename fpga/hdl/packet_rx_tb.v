`timescale 1ns / 1ns

module packet_rx_tb;

reg clk;
integer cc;
reg fault=0;
wire [8:0] round;
initial begin
  $dumpfile("packet_rx.vcd");
  $dumpvars(5, packet_rx_tb);
  for (cc=0; cc<1170; cc=cc+1) begin
    clk=0; #4;
    clk=1; #4;
  end
  if (fault || round != 9) $stop(0);
  $display("PASS");
  $finish(0);
end

reg [7:0] data=0;
reg [1:0] ctl=0;
reg eth_rx_read;  // acknowledgement bit supplied to DUT
wire [47:0] mac_addr = 48'h314159265358;
reg [15:0] st=0;
wire [6:0] m=st[6:0];
assign round=st[15:7];
always @(posedge clk) begin
  st <= st+1;
  if ((m>=20) && (m<31)) begin
    case (m-20)
      0: data <= 8'h55;
      1: data <= 8'h55;
      2: data <= 8'h55;
      3: data <= 8'h55;
      4: data <= 8'hd5;  // end of preamble
      5: data <= 8'h31;  // start of MAC
      6: data <= 8'h41;
      7: data <= 8'h59;
      8: data <= 8'h26;
      9: data <= 8'h53;
      10: data <= 8'h58;  // end of MAC
    endcase
    if (round>1 && (m-23)==round) data <= 8'h33;  // change a dest MAC byte in the packet
  end else if ((m>=39) && (m<103)) begin
    data <= (m-39)*5;
  end else begin
    data <= 8'hxx;
  end
  if ((m>=20) && (m<120)) ctl <= 2'b11;
  else ctl <= 2'b00;
  eth_rx_read <= m == 124;
end

wire [5:0] eth_rx_addr;
wire [7:0] eth_rx_wdata;
wire eth_rx_we;
wire eth_rx_ready;  // status reported by DUT

packet_rx _packet_rx(
  .clk(clk), .data(data), .ctl(ctl),
  .mac_addr(mac_addr),
  .eth_rx_addr(eth_rx_addr), .eth_rx_wdata(eth_rx_wdata), .eth_rx_we(eth_rx_we),
  .eth_rx_ready(eth_rx_ready), .eth_rx_read(eth_rx_read)
);

reg clk_cpu=0;
wire [5:0] eth_rx_raddr=0;
wire [7:0] eth_rx_rdata;
dpram_64 _eth_rx_dpram(
  clk, eth_rx_addr, eth_rx_wdata, eth_rx_we,
  clk_cpu, eth_rx_raddr, eth_rx_rdata
);

integer ix;
reg match, match_plan;
reg [7:0] want;
always @(posedge eth_rx_ready) begin
  #1;
  match = 1;
  for (ix=0; ix<64; ix=ix+1) begin
    want = ix*5;
    // $display(ix, _eth_rx_dpram.mem[ix], want);
    if (_eth_rx_dpram.mem[ix] != want) match=0;
  end
  $display("round %d  %s", round, match?" OK":"BAD");
  match_plan = round==0 || round==1 || round==8;
  if (match != match_plan) fault=1;
  for (ix=0; ix<64; ix=ix+1) _eth_rx_dpram.mem[ix]=8'hxx;
end

endmodule
