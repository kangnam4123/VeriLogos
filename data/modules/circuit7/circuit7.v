module circuit7 (
	input clk,
	input a, 
	output reg q
);
 
	always @(posedge clk)
		q <= ~a;
		
endmodule