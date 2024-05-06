module scbuf_sig_buf (
   scbuf_scdata_fbdecc_c4, scbuf_dram_wr_data_r5, 
   scbuf_dram_data_vld_r5, scbuf_dram_data_mecc_r5, 
   scbuf_sctag_ev_uerr_r5, scbuf_sctag_ev_cerr_r5, 
   scbuf_scdata_fbdecc_c4_pb, scbuf_dram_wr_data_r5_pb, 
   scbuf_dram_data_vld_r5_pb, scbuf_dram_data_mecc_r5_pb, 
   scbuf_sctag_ev_uerr_r5_pb, scbuf_sctag_ev_cerr_r5_pb
   );
output  [623:0]  scbuf_scdata_fbdecc_c4;
output  [63:0]   scbuf_dram_wr_data_r5;
output           scbuf_dram_data_vld_r5;
output           scbuf_dram_data_mecc_r5;
output           scbuf_sctag_ev_uerr_r5;
output           scbuf_sctag_ev_cerr_r5;
input   [623:0]  scbuf_scdata_fbdecc_c4_pb;
input   [63:0]   scbuf_dram_wr_data_r5_pb;
input            scbuf_dram_data_vld_r5_pb;
input            scbuf_dram_data_mecc_r5_pb;
input            scbuf_sctag_ev_uerr_r5_pb;
input            scbuf_sctag_ev_cerr_r5_pb;
assign scbuf_scdata_fbdecc_c4[623:0] = scbuf_scdata_fbdecc_c4_pb[623:0];
assign scbuf_dram_wr_data_r5[63:0]   = scbuf_dram_wr_data_r5_pb[63:0];
assign scbuf_dram_data_vld_r5        = scbuf_dram_data_vld_r5_pb;
assign scbuf_dram_data_mecc_r5       = scbuf_dram_data_mecc_r5_pb;
assign scbuf_sctag_ev_uerr_r5        = scbuf_sctag_ev_uerr_r5_pb;
assign scbuf_sctag_ev_cerr_r5        = scbuf_sctag_ev_cerr_r5_pb;
endmodule