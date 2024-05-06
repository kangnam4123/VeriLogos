module nv_ram_rws_16x272 (
  clk,
  ra,
  re,
  dout,
  wa,
  we,
  di,
  pwrbus_ram_pd
);
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
input clk;
input [3:0] ra;
input re;
output [271:0] dout;
input [3:0] wa;
input we;
input [271:0] di;
input [31:0] pwrbus_ram_pd;
reg [3:0] ra_d;
wire [271:0] dout;
reg [271:0] M [15:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
assign dout = M[ra_d];
endmodule