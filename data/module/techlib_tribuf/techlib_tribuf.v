module techlib_tribuf (A, EN, Y);
parameter WIDTH = 0;
input [WIDTH-1:0] A;
input EN;
output [WIDTH-1:0] Y;
assign Y = EN ? A : 'bz;
endmodule