module ser_to_par #(parameter W=8)
	(input clk , input ser,
	output[W-1:0] par);	
	reg[W-2:0] par_reg = 0;
	always @(posedge clk) begin
		par_reg <= {par_reg[W-3:0], ser};
	end	
	assign par = {par_reg, ser};
endmodule