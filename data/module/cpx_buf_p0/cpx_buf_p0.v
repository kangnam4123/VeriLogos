module cpx_buf_p0(
   scache0_cpx_req_bufp0_cq, scache0_cpx_atom_bufp0_cq, 
   cpx_scache0_grant_bufp0_ca, cpx_spc0_data_rdy_bufp0_cx, 
   scache0_cpx_req_bufpt_cq_l, scache0_cpx_atom_bufpt_cq_l, 
   cpx_scache0_grant_bufp1_ca_l, cpx_spc0_data_rdy_bufp1_cx
   );
   output [7:0]		scache0_cpx_req_bufp0_cq;	
   output 		scache0_cpx_atom_bufp0_cq;	
   output [7:0]		cpx_scache0_grant_bufp0_ca;
   output 		cpx_spc0_data_rdy_bufp0_cx;
   input [7:0]		scache0_cpx_req_bufpt_cq_l;	
   input 		scache0_cpx_atom_bufpt_cq_l;	
   input [7:0]		cpx_scache0_grant_bufp1_ca_l;
   input 		cpx_spc0_data_rdy_bufp1_cx;
   assign 		scache0_cpx_req_bufp0_cq[7:0]		=        ~scache0_cpx_req_bufpt_cq_l[7:0];
   assign 		scache0_cpx_atom_bufp0_cq		=        ~scache0_cpx_atom_bufpt_cq_l;
   assign               cpx_scache0_grant_bufp0_ca              =        ~cpx_scache0_grant_bufp1_ca_l;
   assign     		cpx_spc0_data_rdy_bufp0_cx              =	 cpx_spc0_data_rdy_bufp1_cx;
endmodule