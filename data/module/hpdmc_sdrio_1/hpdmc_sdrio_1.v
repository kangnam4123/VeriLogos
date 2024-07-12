module hpdmc_sdrio_1(
	input             sys_clk,
	input             direction,
	input             direction_r,
	input      [ 1:0] mo,
	input      [15:0] dout,
	output reg [15:0] di,
	output     [ 1:0] sdram_dqm,
	inout      [15:0] sdram_dq
);
wire [15:0] sdram_data_out;
assign sdram_dq = direction ? sdram_data_out : 16'hzzzz;
assign sdram_dqm      = mo;
assign sdram_data_out = dout;
 always @(posedge sys_clk) di <= sdram_dq;
endmodule