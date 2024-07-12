module my_dffre_n (
    input d,
    clk,
    clr,
    en,
    output reg q
);
  always @(posedge clk or negedge clr)
    if (!clr) q <= 1'b0;
    else if (en) q <= d;
endmodule