module  fifo_2k_a_gray2bin_8m4
	( 
	bin,
	gray) ;
	output   [10:0]  bin;
	input   [10:0]  gray;
	wire  xor0;
	wire  xor1;
	wire  xor2;
	wire  xor3;
	wire  xor4;
	wire  xor5;
	wire  xor6;
	wire  xor7;
	wire  xor8;
	wire  xor9;
	assign
		bin = {gray[10], xor9, xor8, xor7, xor6, xor5, xor4, xor3, xor2, xor1, xor0},
		xor0 = (gray[0] ^ xor1),
		xor1 = (gray[1] ^ xor2),
		xor2 = (gray[2] ^ xor3),
		xor3 = (gray[3] ^ xor4),
		xor4 = (gray[4] ^ xor5),
		xor5 = (gray[5] ^ xor6),
		xor6 = (gray[6] ^ xor7),
		xor7 = (gray[7] ^ xor8),
		xor8 = (gray[8] ^ xor9),
		xor9 = (gray[10] ^ gray[9]);
endmodule