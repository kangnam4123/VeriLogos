module LUT2_8(output F, input I0, I1);
	parameter [3:0] INIT = 0;
	wire [ 1: 0] s1 = I1 ? INIT[ 3: 2] : INIT[ 1: 0];
	assign F = I0 ? s1[1] : s1[0];
endmodule