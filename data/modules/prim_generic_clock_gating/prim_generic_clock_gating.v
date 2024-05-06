module prim_generic_clock_gating (
	clock,
	en_i,
	test_en_i,
	clk_o
);
	input clock;
	input en_i;
	input test_en_i;
	output wire clk_o;
	reg en_latch;
	always @(*)
		if (!clock)
			en_latch = en_i | test_en_i;
	assign clk_o = en_latch & clock;
endmodule