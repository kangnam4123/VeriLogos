module INC4 #(parameter SIZE = 4) (input [SIZE-1:0] in, output [SIZE:0] out);
assign out = in + 1;
endmodule