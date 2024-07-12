module dff_23(clk, d, q);
input clk, d;
output reg q;
always @(posedge clk)
	q <= d;
endmodule