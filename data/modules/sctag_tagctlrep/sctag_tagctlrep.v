module sctag_tagctlrep(
   sctag_scdata_set_c2, sctag_scdata_way_sel_c2, 
   sctag_scdata_col_offset_c2, sctag_scdata_rd_wr_c2, 
   sctag_scdata_word_en_c2, sctag_scdata_fbrd_c3, 
   sctag_scdata_fb_hit_c3, 
   scdata_set_c2, scdata_way_sel_c2, scdata_col_offset_c2, 
   scdata_rd_wr_c2, scdata_word_en_c2, scdata_fbrd_c3, 
   scdata_fb_hit_c3
   );
input  [9:0]	scdata_set_c2; 
input  [11:0]  scdata_way_sel_c2;
input  [3:0]   scdata_col_offset_c2;
input          scdata_rd_wr_c2;
input  [15:0]  scdata_word_en_c2;
input		scdata_fbrd_c3;
input		scdata_fb_hit_c3;
output  [9:0]	sctag_scdata_set_c2; 
output  [11:0]  sctag_scdata_way_sel_c2; 
output  [3:0]   sctag_scdata_col_offset_c2; 
output          sctag_scdata_rd_wr_c2; 
output  [15:0]  sctag_scdata_word_en_c2; 
output		sctag_scdata_fbrd_c3; 
output		sctag_scdata_fb_hit_c3; 
assign	sctag_scdata_fb_hit_c3 = scdata_fb_hit_c3;
assign	sctag_scdata_fbrd_c3 = scdata_fbrd_c3 ;
assign	sctag_scdata_word_en_c2 = scdata_word_en_c2;
assign	sctag_scdata_rd_wr_c2 = scdata_rd_wr_c2 ;
assign	sctag_scdata_col_offset_c2 = scdata_col_offset_c2 ;
assign	sctag_scdata_way_sel_c2 = scdata_way_sel_c2;  
assign	sctag_scdata_set_c2 = scdata_set_c2 ; 
endmodule