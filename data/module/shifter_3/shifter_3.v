module shifter_3 #(parameter d_width = 32, ra_width = 5)
	(	output reg [d_width-1:0]res,
		input [d_width-1:0] rin,
		input [ra_width-1:0] shift,
		input dir);
	always @(dir, shift, rin)
		if (~dir)
			res <= (rin << shift);
		else
			res <= (rin >> shift);
endmodule