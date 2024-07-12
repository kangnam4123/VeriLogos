module mult_2 (
    input clk,
    input      signed [16:0] a,
    input      signed [16:0] b,
    output reg signed [33:0] p
  );
  always @(posedge clk) p <= a * b;
endmodule