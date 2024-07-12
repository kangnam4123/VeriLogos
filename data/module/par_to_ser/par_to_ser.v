module par_to_ser #(parameter W=8)
	(input clk , input[W-1:0] par,
	input start, output ser);	
	reg[W-1:0] par_reg = 0;
	always @(posedge clk) begin
		if (start) begin
			par_reg <= {par[W-2:0], 1'b0};	
		end
		else begin
			par_reg <= {par_reg[W-2:0], 1'b0};
		end
	end	
	assign ser = start ? par[W-1] : par_reg[W-1];
endmodule