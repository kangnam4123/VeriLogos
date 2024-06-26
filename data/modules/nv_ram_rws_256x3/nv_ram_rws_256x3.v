module nv_ram_rws_256x3 (
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
input [7:0] ra;
input re;
output [2:0] dout;
input [7:0] wa;
input we;
input [2:0] di;
input [31:0] pwrbus_ram_pd;
reg [7:0] ra_d;
wire [2:0] dout;
reg [2:0] M [255:0];
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