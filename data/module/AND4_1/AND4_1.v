module AND4_1 #(parameter SIZE = 4) (input [SIZE-1:0] in, output out);
assign out = &in;
endmodule