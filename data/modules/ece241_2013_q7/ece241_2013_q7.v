module ece241_2013_q7 (
	input clk,
	input j,
	input k,
	output reg Q
);
 
	always @(posedge clk)
		Q <= j&~Q | ~k&Q;
	
endmodule