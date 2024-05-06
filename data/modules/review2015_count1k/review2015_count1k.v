module review2015_count1k(
	input clk,
	input reset,
	output reg [9:0] q);
 	
	always @(posedge clk)
		if (reset || q == 999)
			q <= 0;
		else
			q <= q+1;
	
endmodule