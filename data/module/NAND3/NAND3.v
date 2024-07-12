module NAND3 (
	input A, B, C,
	output Y
);
	assign Y = !(A & B & C);
endmodule