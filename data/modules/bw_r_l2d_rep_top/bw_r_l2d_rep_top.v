module bw_r_l2d_rep_top (
   word_en_buf, col_offset_buf, set_buf, wr_en_buf, way_sel_buf, 
   decc_in_buf, fbdt_l, fbdb_l, scdata_scbuf_decc_top_buf, 
   scdata_scbuf_decc_bot_buf, 
   word_en_l, col_offset_l, set_l, wr_en_l, way_sel_l, decc_in_l, 
   scbuf_scdata_fbdecc_top, scbuf_scdata_fbdecc_bot, sbdt_l, sbdb_l
   );
   input [3:0]     word_en_l;
   input 	   col_offset_l;
   input [9:0] 	   set_l;
   input 	   wr_en_l;
   input [11:0]    way_sel_l;
   input [155:0]   decc_in_l;
   input [155:0]   scbuf_scdata_fbdecc_top;
   input [155:0]   scbuf_scdata_fbdecc_bot;
   input [155:0]   sbdt_l;
   input [155:0]   sbdb_l;
   output [3:0]    word_en_buf;
   output 	   col_offset_buf;
   output [9:0]    set_buf;
   output 	   wr_en_buf;
   output [11:0]   way_sel_buf;
   output [155:0]  decc_in_buf;
   output [155:0]  fbdt_l;
   output [155:0]  fbdb_l;
   output [155:0]  scdata_scbuf_decc_top_buf;
   output [155:0]  scdata_scbuf_decc_bot_buf;
   assign word_en_buf[3:0] = ~word_en_l[3:0];
   assign col_offset_buf = ~col_offset_l;
   assign set_buf[9:0] = ~set_l[9:0];
   assign wr_en_buf = ~wr_en_l;
   assign way_sel_buf[11:0] = ~way_sel_l[11:0];
   assign decc_in_buf[155:0] = ~decc_in_l[155:0];
   assign fbdt_l[155:0] = ~scbuf_scdata_fbdecc_top[155:0];
   assign fbdb_l[155:0] = ~scbuf_scdata_fbdecc_bot[155:0];
   assign scdata_scbuf_decc_top_buf[155:0] = ~sbdt_l[155:0];
   assign scdata_scbuf_decc_bot_buf[155:0] = ~sbdb_l[155:0];
endmodule