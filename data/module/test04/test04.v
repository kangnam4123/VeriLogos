module test04(a, y);
  input a;
  output [1:0] y;
  assign y = ~(a - 1'b0);
endmodule