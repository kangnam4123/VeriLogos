module my_dffnr_p (
    input d,
    clk,
    clr,
    output reg q
);
  initial q <= 1'b0;
  always @(negedge clk or posedge clr)
    if (clr) q <= 1'b0;
    else q <= d;
endmodule