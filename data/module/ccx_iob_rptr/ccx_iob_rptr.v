module ccx_iob_rptr (
   sig_buf, 
   sig
   );
output	[135:0]	 sig_buf;
input	[135:0]	 sig;
assign	sig_buf = sig;
endmodule