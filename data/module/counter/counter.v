module counter #(
	parameter MAX = 15,
	parameter START = 0,
	parameter signed INC = 1
) (
	input clk,
	input reset,
	input ce,
	output reg [$clog2(MAX+1)-1:0] count = START
);
	localparam TCQ = 1;
	always @(posedge clk)
		if (reset)
			count <= #TCQ START;
		else if (ce)
			count <= #TCQ count + INC;
endmodule