module rsdec_chien_scale3 (y, x);
	input [4:0] x;
	output [4:0] y;
	reg [4:0] y;
	always @ (x)
	begin
		y[0] = x[2];
		y[1] = x[3];
		y[2] = x[2] ^ x[4];
		y[3] = x[0] ^ x[3];
		y[4] = x[1] ^ x[4];
	end
endmodule