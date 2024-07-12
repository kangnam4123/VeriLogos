module  acl_fp_log_altpriority_encoder_3v7
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;
	assign
		q = {data[1]};
endmodule