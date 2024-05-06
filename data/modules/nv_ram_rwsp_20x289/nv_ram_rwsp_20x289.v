module nv_ram_rwsp_20x289 (
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
input [4:0] ra;
input re;
input ore;
output [288:0] dout;
input [4:0] wa;
input we;
input [288:0] di;
input [31:0] pwrbus_ram_pd;
reg [4:0] ra_d;
wire [288:0] dout;
reg [288:0] M [19:0];
always @( posedge clk ) begin
    if (we)
       M[wa] <= di;
end
always @( posedge clk ) begin
    if (re)
       ra_d <= ra;
end
wire [288:0] dout_ram = M[ra_d];
reg [288:0] dout_r;
always @( posedge clk ) begin
   if (ore)
       dout_r <= dout_ram;
end
assign dout = dout_r;
endmodule