module iob_ccx_rptr (
   sig_buf, 
   sig
   );
output  [163:0] sig_buf;
input   [163:0] sig;
assign  sig_buf  = sig;
endmodule