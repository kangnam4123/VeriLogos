module FULL_ADDER_1  # (parameter SIZE=4)
(
	input wire[SIZE-1:0] wA,
	input wire[SIZE-1:0] wB,
	input wire wCi,
	output wire [SIZE-1:0] wR ,
	output wire wCo
);
	assign {wCo,wR} = wA + wB + wCi;
endmodule