module  fpoint_hw_qsys_addsub_single_altpriority_encoder_iha
	( 
	data,
	q) ;
	input   [1:0]  data;
	output   [0:0]  q;
	assign
		q = {data[1]};
endmodule