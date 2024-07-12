module tsb(in, enable, out);
	input [31:0] in;
	input enable;
	output [31:0] out;
	wire [31:0] in, out;
	wire enable;
	assign out = (enable) ? in : 32'bz;
endmodule