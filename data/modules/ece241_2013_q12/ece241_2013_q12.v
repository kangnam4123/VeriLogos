module ece241_2013_q12 (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output Z
);
 
	reg [7:0] q;
	always @(posedge clk) begin
		if (enable)
			q <= {q[6:0], S};
	end
	
	assign Z = q[ {A, B, C} ];
	
endmodule
