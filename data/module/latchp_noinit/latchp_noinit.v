module latchp_noinit (
    input d,
    clk,
    en,
    output reg q
);
  always @* if (en) q <= d;
endmodule