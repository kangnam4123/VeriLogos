module              cog_ram_2
(
input               clk,
input               ena,
input               w,
input        [8:0]  a,
input       [31:0]  d,
output reg  [31:0]  q
);
reg         [31:0]  r [511:0];
always @(posedge clk)
begin
    if (ena && w)
        r[a] <= d;
    if (ena)
        q <= r[a];
end
endmodule