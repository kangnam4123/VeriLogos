module elut_custom #(
	parameter used = 0,
	parameter [0:2**6-1] LUT_MASK={2**6{1'b0}}
) (
	a,
	d,
	dpra,
	clk,
	we,
	dpo,
	qdpo_clk,
	qdpo_rst,
	qdpo);
input [5 : 0] a;
input [0 : 0] d;
input [5 : 0] dpra;
input clk;
input we;
input qdpo_clk;
input qdpo_rst;
output dpo;
output qdpo;
wire lut_output;
wire lut_registered_output;
	generate
		if( used == 1)
		begin
			LUT_K #(
				.K(6),
				.LUT_MASK(LUT_MASK)
				) verification_lut2  (
				.in(dpra),
				.out(lut_output)
				);
			DFF #(
	        .INITIAL_VALUE(1'b0)
	    ) verification_latch  (
	        .D(lut_output),
	        .Q(lut_registered_output),
	        .clock(qdpo_clk)
	    );
		end
		else
		begin
			assign lut_output = 1'b0;
			assign lut_registered_output = 1'b0;
		end
	endgenerate
assign dpo  = lut_output;
assign qdpo = lut_registered_output;
endmodule