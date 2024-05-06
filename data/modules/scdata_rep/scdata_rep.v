module scdata_rep(
   sctag_scdata_col_offset_c2_buf, sctag_scdata_fb_hit_c3_buf, 
   sctag_scdata_fbrd_c3_buf, sctag_scdata_rd_wr_c2_buf, 
   sctag_scdata_set_c2_buf, sctag_scdata_stdecc_c2_buf, 
   sctag_scdata_way_sel_c2_buf, sctag_scdata_word_en_c2_buf, 
   scdata_sctag_decc_c6, 
   sctag_scdata_col_offset_c2, sctag_scdata_fb_hit_c3, 
   sctag_scdata_fbrd_c3, sctag_scdata_rd_wr_c2, sctag_scdata_set_c2, 
   sctag_scdata_stdecc_c2, sctag_scdata_way_sel_c2, 
   sctag_scdata_word_en_c2, scdata_sctag_decc_c6_ctr
   );
   input [3:0]		sctag_scdata_col_offset_c2;
   input		sctag_scdata_fb_hit_c3;
   input		sctag_scdata_fbrd_c3;
   input		sctag_scdata_rd_wr_c2;   
   input [9:0] 		sctag_scdata_set_c2;
   input [77:0] 	sctag_scdata_stdecc_c2;
   input [11:0] 	sctag_scdata_way_sel_c2;
   input [15:0] 	sctag_scdata_word_en_c2;
   input [155:0]	scdata_sctag_decc_c6_ctr;
   output [3:0] 	sctag_scdata_col_offset_c2_buf;
   output		sctag_scdata_fb_hit_c3_buf;
   output		sctag_scdata_fbrd_c3_buf;
   output		sctag_scdata_rd_wr_c2_buf;   
   output [9:0] 	sctag_scdata_set_c2_buf;
   output [77:0] 	sctag_scdata_stdecc_c2_buf;
   output [11:0] 	sctag_scdata_way_sel_c2_buf;
   output [15:0] 	sctag_scdata_word_en_c2_buf;
   output [155:0]	scdata_sctag_decc_c6;   
   assign sctag_scdata_col_offset_c2_buf = sctag_scdata_col_offset_c2;
   assign sctag_scdata_fb_hit_c3_buf = sctag_scdata_fb_hit_c3;
   assign sctag_scdata_fbrd_c3_buf = sctag_scdata_fbrd_c3;
   assign sctag_scdata_rd_wr_c2_buf = sctag_scdata_rd_wr_c2;   
   assign sctag_scdata_set_c2_buf = sctag_scdata_set_c2;
   assign sctag_scdata_stdecc_c2_buf = sctag_scdata_stdecc_c2;
   assign sctag_scdata_way_sel_c2_buf = sctag_scdata_way_sel_c2;
   assign sctag_scdata_word_en_c2_buf = sctag_scdata_word_en_c2;
   assign scdata_sctag_decc_c6 = scdata_sctag_decc_c6_ctr;   
endmodule