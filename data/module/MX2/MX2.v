module MX2 (
	input A, B, S,
	output Y
);
	assign Y = S ? B : A;
endmodule