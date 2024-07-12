module macc # (parameter SIZEIN = 16, SIZEOUT = 40) (
	input clk, ce, sload,
	input signed [SIZEIN-1:0] a, b,
	output signed [SIZEOUT-1:0] accum_out
);
reg signed [SIZEIN-1:0] a_reg = 0, b_reg = 0;
reg sload_reg = 0;
reg signed [2*SIZEIN-1:0] mult_reg = 0;
reg signed [SIZEOUT-1:0] adder_out = 0, old_result;
always @*  begin 
	if (sload_reg)
		old_result <= 0;
	else
		old_result <= adder_out;
end
always @(posedge clk)
	if (ce)
	begin
		a_reg <= a;
		b_reg <= b;
		mult_reg <= a_reg * b_reg;
		sload_reg <= sload;
		adder_out <= old_result + mult_reg;
	end
assign accum_out = adder_out;
endmodule