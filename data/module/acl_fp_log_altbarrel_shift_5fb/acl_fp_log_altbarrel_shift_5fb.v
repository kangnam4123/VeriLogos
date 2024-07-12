module  acl_fp_log_altbarrel_shift_5fb
	( 
	data,
	distance,
	result) ;
	input   [63:0]  data;
	input   [5:0]  distance;
	output   [63:0]  result;
	wire  [6:0]  dir_w;
	wire  direction_w;
	wire  [31:0]  pad_w;
	wire  [447:0]  sbit_w;
	wire  [5:0]  sel_w;
	wire  [383:0]  smux_w;
	assign
		dir_w = {dir_w[5:0], direction_w},
		direction_w = 1'b0,
		pad_w = {32{1'b0}},
		result = sbit_w[447:384],
		sbit_w = {smux_w[383:0], data},
		sel_w = {distance[5:0]},
		smux_w = {((({64{(sel_w[5] & (~ dir_w[5]))}} & {sbit_w[351:320], pad_w[31:0]}) | ({64{(sel_w[5] & dir_w[5])}} & {pad_w[31:0], sbit_w[383:352]})) | ({64{(~ sel_w[5])}} & sbit_w[383:320])), ((({64{(sel_w[4] & (~ dir_w[4]))}} & {sbit_w[303:256], pad_w[15:0]}) | ({64{(sel_w[4] & dir_w[4])}} & {pad_w[15:0], sbit_w[319:272]})) | ({64{(~ sel_w[4])}} & sbit_w[319:256])), ((({64{(sel_w[3] & (~ dir_w[3]))}} & {sbit_w[247:192], pad_w[7:0]}) | ({64{(sel_w[3] & dir_w[3])}} & {pad_w[7:0], sbit_w[255:200]})) | ({64{(~ sel_w[3])}} & sbit_w[255:192])), ((({64{(sel_w[2] & (~ dir_w[2]))}} & {sbit_w[187:128], pad_w[3:0]}) | ({64{(sel_w[2] & dir_w[2])}} & {pad_w[3:0], sbit_w[191:132]})) | ({64{(~ sel_w[2])}} & sbit_w[191:128])), ((({64{(sel_w[1] & (~ dir_w[1]))}} & {sbit_w[125:64], pad_w[1:0]}) | ({64{(sel_w[1] & dir_w[1])}} & {pad_w[1:0], sbit_w[127:66]})) | ({64{(~ sel_w[1])}} & sbit_w[127:64])), ((({64{(sel_w[0] & (~ dir_w[0]))}} & {sbit_w[62:0], pad_w[0]}) | ({64{(sel_w[0] & dir_w[0])}} & {pad_w[0], sbit_w[63:1]})) | ({64{(~ sel_w[0])}} & sbit_w[63:0]))};
endmodule