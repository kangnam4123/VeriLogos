module nv_ram_rwsp_80x514 (
  clk,
  ra,
  re,
  ore,
  dout,
  wa,
  we,
  di,
  pwrbus_ram_pd
);
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
input clk;
input [6:0] ra;
input re;
input ore;
output [513:0] dout;
input [6:0] wa;
input we;
input [513:0] di;
input [31:0] pwrbus_ram_pd;
reg [6:0] ra_d;
wire [513:0] dout;
reg [513:0] M [79:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
wire [513:0] dout_ram = M[ra_d];
reg [513:0] dout_r;
always @( posedge clk ) begin
   if (ore)
       dout_r <= dout_ram;
end
assign dout = dout_r;
endmodule