module MUX_2(O,A,B,sel);
	input wire A,B;
	output wire O;
	input wire sel;
	assign O = (~sel)*A + (sel&B);
endmodule