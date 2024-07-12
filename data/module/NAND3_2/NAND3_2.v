module NAND3_2 #(parameter SIZE = 3) (input [SIZE-1:0] in, output out);
assign out = ~&in;
endmodule