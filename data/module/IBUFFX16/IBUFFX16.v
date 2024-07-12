module IBUFFX16 (INP,ZN);
	input INP;
	output ZN;
	wire ot;
assign ZN = ~ot;
assign ot = INP;
endmodule