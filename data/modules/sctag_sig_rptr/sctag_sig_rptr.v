module sctag_sig_rptr(
   fast_sig_buf, 
   fast_sig
   );
output  [39:0]	fast_sig_buf; 
input	[39:0]  fast_sig;
assign fast_sig_buf = fast_sig ;
endmodule