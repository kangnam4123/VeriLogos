module maj (x, y, z, o);
	input [31:0] x, y, z;
	output [31:0] o;
	assign o = (x & y) | (z & (x | y));
endmodule