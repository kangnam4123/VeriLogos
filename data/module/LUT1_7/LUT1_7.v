module LUT1_7(output F, input I0);
	parameter [1:0] INIT = 0;
	assign F = I0 ? INIT[1] : INIT[0];
endmodule