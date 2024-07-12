module my_dffsre_pnp (
    input d,
    clk,
    pre,
    clr,
    en,
    output reg q
);
  initial q <= 1'b0;
  always @(posedge clk or negedge pre or posedge clr)
    if (!pre) q <= 1'b1;
    else if (clr) q <= 1'b0;
    else if (en) q <= d;
endmodule