module  acl_fp_add_sub_fast_double_altpriority_encoder_n28
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;
	assign
		q = {(~ data[0])};
endmodule