module full_adder_6(a, b, c_in, s, c_out);
	input a, b, c_in;
	output s, c_out;
	wire [2:0] inter_out;
	wire s, c_out;
	xor(inter_out[0], a, b);
	and(inter_out[1], a, b);
	and(inter_out[2], inter_out[0], c_in);
	xor(s, inter_out[0], c_in);
	or(c_out, inter_out[1], inter_out[2]);
endmodule