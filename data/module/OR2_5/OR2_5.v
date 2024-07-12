module OR2_5 #(parameter SIZE = 2) (input [SIZE-1:0] in, output out);
assign out = |in;
endmodule