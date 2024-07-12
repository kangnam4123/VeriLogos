module invtristate (out, in, enable);
output out ;
input  in ;
input enable ;
wire W_1;
	not   U_1	(W_1, in);
	bufif1 drvi_x 	(out, W_1, enable);
endmodule