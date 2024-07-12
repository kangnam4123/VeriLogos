module pcx_buf_p0(
   pcx_spc0_grant_bufp0_pa, spc0_pcx_req_bufp0_pq, 
   spc0_pcx_atom_bufp0_pq, spc1_pcx_req_bufp0_pq, 
   spc1_pcx_atom_bufp0_pq, 
   spc0_pcx_req_bufpt_pq_l, spc0_pcx_atom_bufpt_pq_l, 
   spc1_pcx_req_bufpt_pq_l, spc1_pcx_atom_bufpt_pq_l, 
   pcx_spc0_grant_bufp1_pa_l
   );
   output [4:0]		pcx_spc0_grant_bufp0_pa;
   output [4:0]		spc0_pcx_req_bufp0_pq;	
   output 		spc0_pcx_atom_bufp0_pq;	
   output [4:0]		spc1_pcx_req_bufp0_pq;	
   output 		spc1_pcx_atom_bufp0_pq;	
   input [4:0]		spc0_pcx_req_bufpt_pq_l;	
   input 		spc0_pcx_atom_bufpt_pq_l;	
   input [4:0]		spc1_pcx_req_bufpt_pq_l;	
   input 		spc1_pcx_atom_bufpt_pq_l;	
   input [4:0]		pcx_spc0_grant_bufp1_pa_l;
   assign 		spc0_pcx_req_bufp0_pq[4:0]		=        ~spc0_pcx_req_bufpt_pq_l[4:0];
   assign 		spc0_pcx_atom_bufp0_pq			=        ~spc0_pcx_atom_bufpt_pq_l;
   assign               pcx_spc0_grant_bufp0_pa                 =        ~pcx_spc0_grant_bufp1_pa_l;
   assign 		spc1_pcx_req_bufp0_pq[4:0]		=        ~spc1_pcx_req_bufpt_pq_l[4:0];
   assign 		spc1_pcx_atom_bufp0_pq			=        ~spc1_pcx_atom_bufpt_pq_l;
endmodule