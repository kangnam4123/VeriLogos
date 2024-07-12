module  int_to_fp_altbarrel_shift_brf
	( 
	aclr,
	clk_en,
	clock,
	data,
	distance,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  data;
	input   [4:0]  distance;
	output   [31:0]  result;
	reg	[31:0]	pipe_wl1c;
	reg	[31:0]	pipe_wl2c;
	reg	sel_pipel3d1c;
	reg	sel_pipel4d1c;
	wire  direction_w;
	wire  [15:0]  pad_w;
	wire  [191:0]  sbit_w;
	wire  [4:0]  sel_w;
	initial
		pipe_wl1c = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) pipe_wl1c <= 32'b0;
		else if  (clk_en == 1'b1)   pipe_wl1c <= ((({32{(sel_w[2] & (~ direction_w))}} & {sbit_w[91:64], pad_w[3:0]}) | ({32{(sel_w[2] & direction_w)}} & {pad_w[3:0], sbit_w[95:68]})) | ({32{(~ sel_w[2])}} & sbit_w[95:64]));
	initial
		pipe_wl2c = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) pipe_wl2c <= 32'b0;
		else if  (clk_en == 1'b1)   pipe_wl2c <= ((({32{(sel_w[4] & (~ direction_w))}} & {sbit_w[143:128], pad_w[15:0]}) | ({32{(sel_w[4] & direction_w)}} & {pad_w[15:0], sbit_w[159:144]})) | ({32{(~ sel_w[4])}} & sbit_w[159:128]));
	initial
		sel_pipel3d1c = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipel3d1c <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipel3d1c <= distance[3];
	initial
		sel_pipel4d1c = 0;
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sel_pipel4d1c <= 1'b0;
		else if  (clk_en == 1'b1)   sel_pipel4d1c <= distance[4];
	assign
		direction_w = 1'b0,
		pad_w = {16{1'b0}},
		result = sbit_w[191:160],
		sbit_w = {pipe_wl2c, ((({32{(sel_w[3] & (~ direction_w))}} & {sbit_w[119:96], pad_w[7:0]}) | ({32{(sel_w[3] & direction_w)}} & {pad_w[7:0], sbit_w[127:104]})) | ({32{(~ sel_w[3])}} & sbit_w[127:96])), pipe_wl1c, ((({32{(sel_w[1] & (~ direction_w))}} & {sbit_w[61:32], pad_w[1:0]}) | ({32{(sel_w[1] & direction_w)}} & {pad_w[1:0], sbit_w[63:34]})) | ({32{(~ sel_w[1])}} & sbit_w[63:32])), ((({32{(sel_w[0] & (~ direction_w))}} & {sbit_w[30:0], pad_w[0]}) | ({32{(sel_w[0] & direction_w)}} & {pad_w[0], sbit_w[31:1]})) | ({32{(~ sel_w[0])}} & sbit_w[31:0])), data},
		sel_w = {sel_pipel4d1c, sel_pipel3d1c, distance[2:0]};
endmodule