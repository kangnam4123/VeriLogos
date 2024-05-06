module pcx_buf_p4(
   pcx_spc7_grant_bufp4_pa, spc6_pcx_req_bufp4_pq, 
   spc6_pcx_atom_bufp4_pq, spc7_pcx_req_bufp4_pq, 
   spc7_pcx_atom_bufp4_pq, 
   spc6_pcx_req_bufpt_pq_l, spc6_pcx_atom_bufpt_pq_l, 
   spc7_pcx_req_bufpt_pq_l, spc7_pcx_atom_bufpt_pq_l, 
   pcx_spc7_grant_bufp3_pa_l
   );
   output [4:0]		pcx_spc7_grant_bufp4_pa;
   output [4:0]		spc6_pcx_req_bufp4_pq;	
   output 		spc6_pcx_atom_bufp4_pq;	
   output [4:0]		spc7_pcx_req_bufp4_pq;	
   output 		spc7_pcx_atom_bufp4_pq;	
   input [4:0]		spc6_pcx_req_bufpt_pq_l;	
   input 		spc6_pcx_atom_bufpt_pq_l;	
   input [4:0]		spc7_pcx_req_bufpt_pq_l;	
   input 		spc7_pcx_atom_bufpt_pq_l;	
   input [4:0]		pcx_spc7_grant_bufp3_pa_l;
   assign               pcx_spc7_grant_bufp4_pa                 =        ~pcx_spc7_grant_bufp3_pa_l;
   assign        	spc6_pcx_req_bufp4_pq[4:0]		=        ~spc6_pcx_req_bufpt_pq_l[4:0];
   assign 		spc6_pcx_atom_bufp4_pq			=        ~spc6_pcx_atom_bufpt_pq_l;
   assign        	spc7_pcx_req_bufp4_pq[4:0]		=        ~spc7_pcx_req_bufpt_pq_l[4:0];
   assign 		spc7_pcx_atom_bufp4_pq			=        ~spc7_pcx_atom_bufpt_pq_l;
endmodule