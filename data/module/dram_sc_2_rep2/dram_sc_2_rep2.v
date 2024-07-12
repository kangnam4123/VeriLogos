module dram_sc_2_rep2(
   dram_scbuf_data_r2_buf, dram_scbuf_ecc_r2_buf, 
   scbuf_dram_wr_data_r5_buf, scbuf_dram_data_vld_r5_buf, 
   scbuf_dram_data_mecc_r5_buf, sctag_dram_rd_req_buf, 
   sctag_dram_rd_dummy_req_buf, sctag_dram_rd_req_id_buf, 
   sctag_dram_addr_buf, sctag_dram_wr_req_buf, dram_sctag_rd_ack_buf, 
   dram_sctag_wr_ack_buf, dram_sctag_chunk_id_r0_buf, 
   dram_sctag_data_vld_r0_buf, dram_sctag_rd_req_id_r0_buf, 
   dram_sctag_secc_err_r2_buf, dram_sctag_mecc_err_r2_buf, 
   dram_sctag_scb_mecc_err_buf, dram_sctag_scb_secc_err_buf, 
   dram_scbuf_data_r2, dram_scbuf_ecc_r2, scbuf_dram_wr_data_r5, 
   scbuf_dram_data_vld_r5, scbuf_dram_data_mecc_r5, 
   sctag_dram_rd_req, sctag_dram_rd_dummy_req, sctag_dram_rd_req_id, 
   sctag_dram_addr, sctag_dram_wr_req, dram_sctag_rd_ack, 
   dram_sctag_wr_ack, dram_sctag_chunk_id_r0, dram_sctag_data_vld_r0, 
   dram_sctag_rd_req_id_r0, dram_sctag_secc_err_r2, 
   dram_sctag_mecc_err_r2, dram_sctag_scb_mecc_err, 
   dram_sctag_scb_secc_err
   );
   input [127:0]        dram_scbuf_data_r2;
   input [27:0]         dram_scbuf_ecc_r2;
   output [127:0]       dram_scbuf_data_r2_buf;
   output [27:0]        dram_scbuf_ecc_r2_buf;
   input [63:0]         scbuf_dram_wr_data_r5;
   input                scbuf_dram_data_vld_r5;
   input                scbuf_dram_data_mecc_r5;
   output [63:0]        scbuf_dram_wr_data_r5_buf;
   output               scbuf_dram_data_vld_r5_buf;
   output               scbuf_dram_data_mecc_r5_buf;
   input        sctag_dram_rd_req;
   input        sctag_dram_rd_dummy_req;
   input [2:0]  sctag_dram_rd_req_id;
   input [39:5] sctag_dram_addr;
   input        sctag_dram_wr_req;
   output       sctag_dram_rd_req_buf;
   output       sctag_dram_rd_dummy_req_buf;
   output [2:0] sctag_dram_rd_req_id_buf;
   output [39:5]        sctag_dram_addr_buf;
   output       sctag_dram_wr_req_buf;
input                   dram_sctag_rd_ack;
input                   dram_sctag_wr_ack;
input  [1:0]            dram_sctag_chunk_id_r0;
input                   dram_sctag_data_vld_r0;
input  [2:0]            dram_sctag_rd_req_id_r0;
input                   dram_sctag_secc_err_r2 ;
input                   dram_sctag_mecc_err_r2 ;
input                   dram_sctag_scb_mecc_err;
input                   dram_sctag_scb_secc_err;
output                   dram_sctag_rd_ack_buf;
output                   dram_sctag_wr_ack_buf;
output  [1:0]            dram_sctag_chunk_id_r0_buf;
output                   dram_sctag_data_vld_r0_buf;
output  [2:0]            dram_sctag_rd_req_id_r0_buf;
output                   dram_sctag_secc_err_r2_buf ;
output                   dram_sctag_mecc_err_r2_buf ;
output                   dram_sctag_scb_mecc_err_buf;
output                   dram_sctag_scb_secc_err_buf;
assign	dram_scbuf_data_r2_buf = dram_scbuf_data_r2 ;
assign	dram_scbuf_ecc_r2_buf = dram_scbuf_ecc_r2 ;
assign	scbuf_dram_wr_data_r5_buf = scbuf_dram_wr_data_r5 ;
assign	scbuf_dram_data_vld_r5_buf = scbuf_dram_data_vld_r5 ;
assign	scbuf_dram_data_mecc_r5_buf = scbuf_dram_data_mecc_r5 ;
assign  dram_sctag_rd_ack_buf = dram_sctag_rd_ack ;
assign  dram_sctag_wr_ack_buf = dram_sctag_wr_ack ;
assign  dram_sctag_chunk_id_r0_buf = dram_sctag_chunk_id_r0 ;
assign  dram_sctag_data_vld_r0_buf = dram_sctag_data_vld_r0;
assign  dram_sctag_rd_req_id_r0_buf = dram_sctag_rd_req_id_r0;
assign  dram_sctag_secc_err_r2_buf = dram_sctag_secc_err_r2;
assign  dram_sctag_mecc_err_r2_buf = dram_sctag_mecc_err_r2;
assign     dram_sctag_scb_mecc_err_buf = dram_sctag_scb_mecc_err;
assign     dram_sctag_scb_secc_err_buf = dram_sctag_scb_secc_err;
   assign       sctag_dram_rd_req_buf =  sctag_dram_rd_req ;
   assign       sctag_dram_rd_dummy_req_buf = sctag_dram_rd_dummy_req ;
   assign sctag_dram_rd_req_id_buf = sctag_dram_rd_req_id ;
   assign         sctag_dram_addr_buf = sctag_dram_addr ;
   assign       sctag_dram_wr_req_buf = sctag_dram_wr_req ;
endmodule