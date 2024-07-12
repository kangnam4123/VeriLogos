module my_dffs_n (
    input d,
    clk,
    pre,
    output reg q
);
  always @(posedge clk or negedge pre)
    if (!pre) q <= 1'b1;
    else q <= d;
endmodule