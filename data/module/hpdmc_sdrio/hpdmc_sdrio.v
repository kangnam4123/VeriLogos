module hpdmc_sdrio(
	input             sys_clk,
	input             direction,
	input             direction_r,
	input      [ 1:0] mo,
	input      [15:0] dat_o,
	output reg [15:0] dat_i,
	output     [ 1:0] sdram_dqm,
	inout      [15:0] sdram_dq
);
wire [15:0] sdram_data_out;
assign sdram_dq = direction ? sdram_data_out : 16'hzzzz;
assign sdram_dqm      = mo;
assign sdram_data_out = dat_o;
always @(posedge sys_clk) dat_i <= sdram_dq;
endmodule