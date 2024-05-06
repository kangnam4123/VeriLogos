module m2014_q4d (
	input clk,
	input in,
	output logic out
);
 
	initial
		out = 0;
		
	always@(posedge clk) begin
		out <= in ^ out;
	end

endmodule