module test03(a, b, y);
  input [2:0] a;
  input signed [1:0] b;
  output y;
  assign y = ~(a >>> 1) == b;
endmodule