module fpu_rptr_fp_cpx_grp16 (
	in,
	out
);
	input [15:0] in;
	output [15:0] out;
	assign out[15:0] = in[15:0];
endmodule