module sctag_min_rptr(
   sig_buf, 
   sig
   );
input	[15:0]	sig;
output	[15:0]	sig_buf;
assign	sig_buf = sig ;
endmodule