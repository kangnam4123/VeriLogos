module INC16 #(parameter SIZE = 16) (input [SIZE-1:0] in, output [SIZE:0] out);
assign out = in + 1;
endmodule