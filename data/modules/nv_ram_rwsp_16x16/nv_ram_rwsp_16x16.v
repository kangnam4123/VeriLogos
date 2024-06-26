module nv_ram_rwsp_16x16 (
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
input [3:0] ra;
input re;
input ore;
output [15:0] dout;
input [3:0] wa;
input we;
input [15:0] di;
input [31:0] pwrbus_ram_pd;
reg [3:0] ra_d;
wire [15:0] dout;
reg [15:0] M [15:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
wire [15:0] dout_ram = M[ra_d];
reg [15:0] dout_r;
always @( posedge clk ) begin
   if (ore)
       dout_r <= dout_ram;
end
assign dout = dout_r;
endmodule