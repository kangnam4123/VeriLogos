module sctag_dirg_buf(
   lkup_wr_data_up_buf, lkup_wr_data_dn_buf, 
   dirrep_dir_wr_par_c4, dir_vld_c4_l, lkup_addr8_c4, 
   tagdp_lkup_addr_c4
   );
input		dirrep_dir_wr_par_c4; 
input		dir_vld_c4_l; 
input		lkup_addr8_c4; 
input	[39:10]	tagdp_lkup_addr_c4; 
output	[32:0]	lkup_wr_data_up_buf;	
output	[32:0]	lkup_wr_data_dn_buf;    
assign	lkup_wr_data_up_buf = { tagdp_lkup_addr_c4, lkup_addr8_c4, dirrep_dir_wr_par_c4, dir_vld_c4_l };
assign	lkup_wr_data_dn_buf = { tagdp_lkup_addr_c4 , lkup_addr8_c4, dirrep_dir_wr_par_c4, dir_vld_c4_l }; 
endmodule