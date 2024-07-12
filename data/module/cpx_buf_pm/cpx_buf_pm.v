module cpx_buf_pm(
   cpx_scache_grant_bufpm_ca, scache_cpx_req_bufpm_cq, 
   scache_cpx_atom_bufpm_cq, 
   cpx_scache_grant_ca, scache_cpx_req_bufpt_cq_l, 
   scache_cpx_atom_bufpt_cq_l
   );
   output [7:0]         cpx_scache_grant_bufpm_ca;
   output [7:0]		scache_cpx_req_bufpm_cq		        ;	
   output 		scache_cpx_atom_bufpm_cq		        ;	
   input [7:0]          cpx_scache_grant_ca;
   input [7:0]		scache_cpx_req_bufpt_cq_l;	
   input 		scache_cpx_atom_bufpt_cq_l;	
   assign               cpx_scache_grant_bufpm_ca      =                  cpx_scache_grant_ca;
   assign		scache_cpx_req_bufpm_cq[7:0]		=        ~scache_cpx_req_bufpt_cq_l[7:0];
   assign 		scache_cpx_atom_bufpm_cq		=        ~scache_cpx_atom_bufpt_cq_l;
endmodule