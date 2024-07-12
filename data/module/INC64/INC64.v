module INC64 #(parameter SIZE = 64) (input [SIZE-1:0] in, output [SIZE:0] out);
assign out = in + 1;
endmodule