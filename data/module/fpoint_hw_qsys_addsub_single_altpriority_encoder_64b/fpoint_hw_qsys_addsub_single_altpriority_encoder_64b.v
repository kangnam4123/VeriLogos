module  fpoint_hw_qsys_addsub_single_altpriority_encoder_64b
	( 
	data,
	q,
	zero) ;
	input   [1:0]  data;
	output   [0:0]  q;
	output   zero;
	assign
		q = {(~ data[0])},
		zero = (~ (data[0] | data[1]));
endmodule