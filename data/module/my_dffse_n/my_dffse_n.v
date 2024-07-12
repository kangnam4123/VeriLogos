module my_dffse_n (
    input d,
    clk,
    pre,
    en,
    output reg q
);
  always @(posedge clk or negedge pre)
    if (!pre) q <= 1'b1;
    else if (en) q <= d;
endmodule