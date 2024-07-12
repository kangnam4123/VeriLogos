module macc2 # (parameter SIZEIN = 16, SIZEOUT = 40) (
	input clk,
	input ce,
	input rst,
	input signed [SIZEIN-1:0] a, b,
	output signed [SIZEOUT-1:0] accum_out,
	output overflow
);
reg signed [SIZEIN-1:0] a_reg = 0, b_reg = 0, a_reg2 = 0, b_reg2 = 0;
reg signed [2*SIZEIN-1:0] mult_reg = 0;
reg signed [SIZEOUT:0] adder_out = 0;
reg overflow_reg = 0;
always @(posedge clk) begin
	begin
		a_reg <= a;
		b_reg <= b;
		a_reg2 <= a_reg;
		b_reg2 <= b_reg;
		mult_reg <= a_reg2 * b_reg2;
		adder_out <= adder_out + mult_reg;
		overflow_reg <= overflow;
	end
	if (rst) begin
		a_reg <= 0;
		a_reg2 <= 0;
		b_reg <= 0;
		b_reg2 <= 0;
		mult_reg <= 0;
		adder_out <= 0;
		overflow_reg <= 1'b0;
	end
end
assign overflow = (adder_out >= 2**(SIZEOUT-1)) | overflow_reg;
assign accum_out = overflow ? 2**(SIZEOUT-1)-1 : adder_out;
endmodule