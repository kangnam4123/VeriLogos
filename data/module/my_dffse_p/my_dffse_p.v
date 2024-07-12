module my_dffse_p (
    input d,
    clk,
    pre,
    en,
    output reg q
);
  always @(posedge clk or posedge pre)
    if (pre) q <= 1'b1;
    else if (en) q <= d;
endmodule