module nop_1(d,q);
parameter WIDTH=32;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
  assign q=d;
endmodule