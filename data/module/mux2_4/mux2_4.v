module mux2_4
	#(parameter width=16)
	(input [width-1:0] A, B,
	 input sel,
	 output [width-1:0] out);
	assign out = sel ? A : B;
endmodule