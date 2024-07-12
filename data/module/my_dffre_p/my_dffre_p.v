module my_dffre_p (
    input d,
    clk,
    clr,
    en,
    output reg q
);
  always @(posedge clk or posedge clr)
    if (clr) q <= 1'b0;
    else if (en) q <= d;
endmodule