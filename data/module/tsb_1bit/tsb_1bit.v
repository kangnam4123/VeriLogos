module tsb_1bit(in, enable, out);
	input in, enable;
	output out;
	wire in, enable, out;
	assign out = (enable) ? in : 1'bz;
endmodule