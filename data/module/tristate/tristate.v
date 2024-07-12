module tristate (out, in, enable);
output out ;
input  in ;
input enable ;
	bufif1  drv_x (out, in, enable);
endmodule