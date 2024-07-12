module my_dffsr_pnn (
    input d,
    clk,
    pre,
    clr,
    output reg q
);
  initial q <= 1'b0;
  always @(posedge clk or negedge pre or negedge clr)
    if (!pre) q <= 1'b1;
    else if (!clr) q <= 1'b0;
    else q <= d;
endmodule