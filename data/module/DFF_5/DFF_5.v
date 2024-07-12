module DFF_5 (
	input CLK, D,
	output reg Q
);
	initial Q = 1'b0;
	always @(posedge CLK)
		Q <= D;
endmodule