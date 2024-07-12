module zeroer_1(d,en,q);
parameter WIDTH=32;
input en;
input [WIDTH-1:0] d;
output [WIDTH-1:0] q;
assign q= (en) ? d : 0;
endmodule