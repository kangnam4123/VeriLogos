module rep_jbi_sc0_2(
   jbi_sctag_req_buf, scbuf_jbi_data_buf, jbi_scbuf_ecc_buf, 
   jbi_sctag_req_vld_buf, scbuf_jbi_ctag_vld_buf, 
   scbuf_jbi_ue_err_buf, sctag_jbi_iq_dequeue_buf, 
   sctag_jbi_wib_dequeue_buf, sctag_jbi_por_req_buf, 
   jbi_sctag_req, scbuf_jbi_data, jbi_scbuf_ecc, jbi_sctag_req_vld, 
   scbuf_jbi_ctag_vld, scbuf_jbi_ue_err, sctag_jbi_iq_dequeue, 
   sctag_jbi_wib_dequeue, sctag_jbi_por_req
   );
   output [31:0]        jbi_sctag_req_buf;         
   output [31:0]        scbuf_jbi_data_buf;        
   output [6:0]         jbi_scbuf_ecc_buf;         
   output               jbi_sctag_req_vld_buf;     
   output               scbuf_jbi_ctag_vld_buf;
   output               scbuf_jbi_ue_err_buf;      
   output		sctag_jbi_iq_dequeue_buf;
   output		sctag_jbi_wib_dequeue_buf;
   output		sctag_jbi_por_req_buf;
   input [31:0]        jbi_sctag_req;         
   input [31:0]        scbuf_jbi_data;        
   input [6:0]         jbi_scbuf_ecc;         
   input               jbi_sctag_req_vld;     
   input               scbuf_jbi_ctag_vld;
   input               scbuf_jbi_ue_err;      
   input	       sctag_jbi_iq_dequeue;
   input	       sctag_jbi_wib_dequeue;
   input	       sctag_jbi_por_req;
assign		jbi_sctag_req_buf = jbi_sctag_req ;
assign		scbuf_jbi_data_buf = scbuf_jbi_data ;
assign		jbi_scbuf_ecc_buf[6:0] = jbi_scbuf_ecc[6:0] ;
assign		jbi_sctag_req_vld_buf = jbi_sctag_req_vld ;
assign		scbuf_jbi_ctag_vld_buf = scbuf_jbi_ctag_vld ;
assign		scbuf_jbi_ue_err_buf = scbuf_jbi_ue_err ;
assign		sctag_jbi_iq_dequeue_buf = sctag_jbi_iq_dequeue ;
assign		sctag_jbi_wib_dequeue_buf =  sctag_jbi_wib_dequeue;
assign		sctag_jbi_por_req_buf = sctag_jbi_por_req ;
endmodule