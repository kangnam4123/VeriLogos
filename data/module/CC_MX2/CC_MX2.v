module CC_MX2 (
	input  D0, D1,
	input  S0,
	output Y
);
	assign Y = S0 ? D1 : D0;
endmodule