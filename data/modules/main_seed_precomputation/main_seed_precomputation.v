module main_seed_precomputation (a,b,c,IsIntra16x16,main_seed);
	input [13:0] a;
	input [11:0] b,c;
	input IsIntra16x16;
	output [15:0] main_seed;
	wire [14:0]	b_x8_or_x4;
	wire [14:0] c_x8_or_x4;
	wire [11:0] neg_b;
	wire [14:0] b_x7_or_x3;
	wire [15:0] neg_b_x7_or_x3;
	wire [15:0] neg_c_x8_or_x4;
	assign b_x8_or_x4 = (IsIntra16x16)? {b[11:0],3'b0}:{b[11],b[11:0],2'b0};
	assign c_x8_or_x4 = (IsIntra16x16)? {c[11:0],3'b0}:{c[11],c[11:0],2'b0};
	assign neg_b = ~ b;
	assign b_x7_or_x3 = b_x8_or_x4 + {{3{neg_b[11]}},neg_b} + 1;
	assign neg_b_x7_or_x3 = {~b_x7_or_x3[14],~b_x7_or_x3} + 1;
	assign neg_c_x8_or_x4 = {~c_x8_or_x4[14],~c_x8_or_x4} + 1;
	assign main_seed = {a[13],a[13],a} + (neg_c_x8_or_x4 + neg_b_x7_or_x3);
endmodule