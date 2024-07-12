module  fpoint_qsys_addsub_single_altpriority_encoder_6la
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;
	assign
		q = {(~ data[0])};
endmodule