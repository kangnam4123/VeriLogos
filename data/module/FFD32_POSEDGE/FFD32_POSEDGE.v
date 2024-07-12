module FFD32_POSEDGE
(
	input wire Clock,
	input wire[31:0] D,
	output reg[31:0] Q
);
	always @ (posedge Clock)
		Q <= D;
endmodule