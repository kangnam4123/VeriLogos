module my_dffr_n (
    input d,
    clk,
    clr,
    output reg q
);
  always @(posedge clk or negedge clr)
    if (!clr) q <= 1'b0;
    else q <= d;
endmodule