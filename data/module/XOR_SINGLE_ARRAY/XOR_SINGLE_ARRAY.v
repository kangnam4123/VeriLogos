module XOR_SINGLE_ARRAY(O,A);
	parameter m=163;
	input wire[0:m-1] A;
	output wire O;
	assign O = ^A;
endmodule