module NAND2 (
	input A, B,
	output Y
);
	assign Y = !(A & B);
endmodule