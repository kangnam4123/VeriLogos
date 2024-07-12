module INC32 #(parameter SIZE = 32) (input [SIZE-1:0] in, output [SIZE:0] out);
assign out = in + 1;
endmodule