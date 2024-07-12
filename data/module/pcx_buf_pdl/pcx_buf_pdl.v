module pcx_buf_pdl(
   pcx_spc_grant_bufpdl_pa, 
   pcx_spc_grant_bufp1_pa_l
   );
   output [4:0] 	pcx_spc_grant_bufpdl_pa;
   input [4:0] 		pcx_spc_grant_bufp1_pa_l;
   assign pcx_spc_grant_bufpdl_pa =	~pcx_spc_grant_bufp1_pa_l;
endmodule