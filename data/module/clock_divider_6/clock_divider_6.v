module clock_divider_6(input clk_in, output reg clk_out = 0);
	always @(posedge clk_in) begin
		clk_out <= ~clk_out;
	end
endmodule