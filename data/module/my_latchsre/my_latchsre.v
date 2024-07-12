module my_latchsre (
    input d,
    clk,
    en,
    clr,
    pre,
    output reg q
);
  always @*
    if (clr) q <= 1'b0;
    else if (pre) q <= 1'b1;
    else if (en) q <= d;
endmodule