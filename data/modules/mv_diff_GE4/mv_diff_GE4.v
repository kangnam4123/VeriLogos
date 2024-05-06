module mv_diff_GE4 (mv_a,mv_b,diff_GE4);
	input [7:0] mv_a,mv_b;
	output diff_GE4;
	wire [7:0] diff_tmp;
	wire [6:0] diff;
	assign diff_tmp = mv_a + ~ mv_b + 1;
	assign diff	= (diff_tmp[7] == 1'b1)? (~diff_tmp[6:0] + 1):diff_tmp[6:0];
	assign diff_GE4 = (diff[6:2] != 0)? 1'b1:1'b0;
endmodule