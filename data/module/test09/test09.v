module test09(a, b, c, y);
  input a;
  input signed [1:0] b;
  input signed [2:0] c;
  output [3:0] y;
  assign y = a ? b : c;
endmodule