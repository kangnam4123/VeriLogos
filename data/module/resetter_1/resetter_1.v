module resetter_1(
	clk,
	rst_in1_n,
	rst_in2_n,
	rst_out_n );
parameter RST_CNT_SIZE = 3;
	input clk;
	input rst_in1_n; 
	input rst_in2_n; 
	output reg rst_out_n; 
	reg [RST_CNT_SIZE:0] rst_cnt; 
	reg rst1_n,rst2_n;
	wire resets_n;
	assign resets_n = rst_in1_n & rst_in2_n;
	always @(posedge clk, negedge resets_n)
	if( !resets_n ) 
	begin
		rst_cnt <= 0;
		rst1_n <= 1'b0;
		rst2_n <= 1'b0; 
		rst_out_n <= 1'b0; 
	end
	else 
	begin
		rst1_n <= 1'b1;
		rst2_n <= rst1_n;
		if( rst2_n && !rst_cnt[RST_CNT_SIZE] )
		begin
			rst_cnt <= rst_cnt + 1;
		end
		rst_out_n <= rst_cnt[RST_CNT_SIZE];
	end
endmodule