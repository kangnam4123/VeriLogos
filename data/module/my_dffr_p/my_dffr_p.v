module my_dffr_p (
    input d,
    clk,
    clr,
    output reg q
);
  always @(posedge clk or posedge clr)
    if (clr) q <= 1'b0;
    else q <= d;
endmodule