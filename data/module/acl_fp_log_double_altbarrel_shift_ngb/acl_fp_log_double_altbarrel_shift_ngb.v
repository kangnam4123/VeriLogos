module  acl_fp_log_double_altbarrel_shift_ngb
	( 
	data,
	distance,
	result) ;
	input   [127:0]  data;
	input   [6:0]  distance;
	output   [127:0]  result;
	wire  [7:0]  dir_w;
	wire  direction_w;
	wire  [63:0]  pad_w;
	wire  [1023:0]  sbit_w;
	wire  [6:0]  sel_w;
	wire  [895:0]  smux_w;
	assign
		dir_w = {dir_w[6:0], direction_w},
		direction_w = 1'b0,
		pad_w = {64{1'b0}},
		result = sbit_w[1023:896],
		sbit_w = {smux_w[895:0], data},
		sel_w = {distance[6:0]},
		smux_w = {((({128{(sel_w[6] & (~ dir_w[6]))}} & {sbit_w[831:768], pad_w[63:0]}) | ({128{(sel_w[6] & dir_w[6])}} & {pad_w[63:0], sbit_w[895:832]})) | ({128{(~ sel_w[6])}} & sbit_w[895:768])), ((({128{(sel_w[5] & (~ dir_w[5]))}} & {sbit_w[735:640], pad_w[31:0]}) | ({128{(sel_w[5] & dir_w[5])}} & {pad_w[31:0], sbit_w[767:672]})) | ({128{(~ sel_w[5])}} & sbit_w[767:640])), ((({128{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[623:512], pad_w[15:0]}) | ({128{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[639:528]})) | ({128{(~ sel_w[4])}} & sbit_w[639:512])), ((({128{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[503:384], pad_w[7:0]}) | ({128{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[511:392]})) | ({128{(~ sel_w[3])}} & sbit_w[511:384])), ((({128{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[379:256], pad_w[3:0]}) | ({128{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[383:260]})) | ({128{(~ sel_w[2])}} & sbit_w[383:256])), ((({128{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[253:128], pad_w[1:0]}) | ({128{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[255:130]})) | ({128{(~ sel_w[1])}} & sbit_w[255:128])), ((({128{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[126:0], pad_w[0]}) | ({128{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[127:1]})) | ({128{(~ sel_w[0])}} & sbit_w[127:0]))};
endmodule