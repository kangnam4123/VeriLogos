module rsdec_chien_scale1 (y, x);
	input [8:0] x;
	output [8:0] y;
	reg [8:0] y;
	always @ (x)
	begin
		y[0] = x[8];
		y[1] = x[0];
		y[2] = x[1];
		y[3] = x[2];
		y[4] = x[3] ^ x[8];
		y[5] = x[4];
		y[6] = x[5];
		y[7] = x[6];
		y[8] = x[7];
	end
endmodule