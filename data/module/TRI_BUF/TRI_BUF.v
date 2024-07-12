module TRI_BUF(O,A,E);
	input wire A,E;
	output wire O;
	assign O = (E)?A:1'bz;
endmodule