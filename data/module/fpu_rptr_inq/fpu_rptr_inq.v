module fpu_rptr_inq (
	in,
	out
);
	input [155:0] in;
	output [155:0] out;
	assign out[155:0] = in[155:0];
endmodule