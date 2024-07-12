module my_dffs_clk_n (
    input d,
    clk,
    clr,
    output reg q
);
  initial q <= 0;
  always @(negedge clk)
    if (!clr) q <= 1'b0;
    else q <= d;
endmodule