module rsdec_chien_scale2 (y, x);
	input [4:0] x;
	output [4:0] y;
	reg [4:0] y;
	always @ (x)
	begin
		y[0] = x[3];
		y[1] = x[4];
		y[2] = x[0] ^ x[3];
		y[3] = x[1] ^ x[4];
		y[4] = x[2];
	end
endmodule