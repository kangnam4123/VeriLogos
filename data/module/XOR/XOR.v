module XOR(O,A,B);
	input wire A,B;
	output wire O;
	assign O = (~A)*B + A*(~B);
endmodule