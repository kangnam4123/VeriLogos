module fpu_bufrpt_grp32 (
	in,
	out
);
	input [31:0] in;
	output [31:0] out;
	assign out[31:0] = in[31:0];
endmodule