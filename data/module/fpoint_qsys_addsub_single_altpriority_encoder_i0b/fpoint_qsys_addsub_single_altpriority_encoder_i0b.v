module  fpoint_qsys_addsub_single_altpriority_encoder_i0b
	( 
	data,
	q,
	zero) ;
	input   [1:0]  data;
	output   [0:0]  q;
	output   zero;
	assign
		q = {data[1]},
		zero = (~ (data[0] | data[1]));
endmodule