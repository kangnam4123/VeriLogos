module cpx_fpbuf_p0(
   fp_cpx_req_bufp0_cq, 
   fp_cpx_req_bufpt_cq_l
   );
input	[7:0]	fp_cpx_req_bufpt_cq_l;
output	[7:0]	fp_cpx_req_bufp0_cq;
assign               fp_cpx_req_bufp0_cq[7:0]                =        ~fp_cpx_req_bufpt_cq_l[7:0];
endmodule