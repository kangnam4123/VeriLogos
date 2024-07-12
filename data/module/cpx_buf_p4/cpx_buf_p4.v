module cpx_buf_p4(
   scache3_cpx_req_bufp4_cq, scache3_cpx_atom_bufp4_cq, 
   io_cpx_req_bufp4_cq, cpx_scache3_grant_bufp4_ca, 
   cpx_spc7_data_rdy_bufp4_cx, 
   scache3_cpx_req_bufpt_cq_l, scache3_cpx_atom_bufpt_cq_l, 
   io_cpx_req_bufpt_cq_l, cpx_scache3_grant_bufp3_ca_l, 
   cpx_spc7_data_rdy_bufp3_cx
   );
   output [7:0]		scache3_cpx_req_bufp4_cq;	
   output 		scache3_cpx_atom_bufp4_cq;	
   output [7:0]		io_cpx_req_bufp4_cq;
   output [7:0]		cpx_scache3_grant_bufp4_ca;
   output     		cpx_spc7_data_rdy_bufp4_cx;
   input [7:0]		scache3_cpx_req_bufpt_cq_l;	
   input 		scache3_cpx_atom_bufpt_cq_l;	
   input [7:0]		io_cpx_req_bufpt_cq_l;
   input [7:0]		cpx_scache3_grant_bufp3_ca_l;
   input     		cpx_spc7_data_rdy_bufp3_cx;
   assign 		scache3_cpx_req_bufp4_cq[7:0]		=        ~scache3_cpx_req_bufpt_cq_l[7:0];
   assign 		scache3_cpx_atom_bufp4_cq		=        ~scache3_cpx_atom_bufpt_cq_l;
   assign 		io_cpx_req_bufp4_cq[7:0]		=        ~io_cpx_req_bufpt_cq_l[7:0];
   assign               cpx_scache3_grant_bufp4_ca              =        ~cpx_scache3_grant_bufp3_ca_l;
   assign     		cpx_spc7_data_rdy_bufp4_cx              =         cpx_spc7_data_rdy_bufp3_cx;
endmodule