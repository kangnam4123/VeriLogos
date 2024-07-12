module wb_mux_1
  #(parameter dw = 32,        
    parameter aw = 32,        
    parameter num_slaves = 2, 
    parameter [num_slaves*aw-1:0] MATCH_ADDR = 0,
    parameter [num_slaves*aw-1:0] MATCH_MASK = 0)
   (input                      wb_clk_i,
    input 		       wb_rst_i,
    input [aw-1:0] 	       wbm_adr_i,
    input [dw-1:0] 	       wbm_dat_i,
    input [3:0] 	       wbm_sel_i,
    input 		       wbm_we_i,
    input 		       wbm_cyc_i,
    input 		       wbm_stb_i,
    input [2:0] 	       wbm_cti_i,
    input [1:0] 	       wbm_bte_i,
    output [dw-1:0] 	       wbm_dat_o,
    output 		       wbm_ack_o,
    output 		       wbm_err_o,
    output 		       wbm_rty_o,
    output [num_slaves*aw-1:0] wbs_adr_o,
    output [num_slaves*dw-1:0] wbs_dat_o,
    output [num_slaves*4-1:0]  wbs_sel_o,
    output [num_slaves-1:0]    wbs_we_o,
    output [num_slaves-1:0]    wbs_cyc_o,
    output [num_slaves-1:0]    wbs_stb_o,
    output [num_slaves*3-1:0]  wbs_cti_o,
    output [num_slaves*2-1:0]  wbs_bte_o,
    input [num_slaves*dw-1:0]  wbs_dat_i,
    input [num_slaves-1:0]     wbs_ack_i,
    input [num_slaves-1:0]     wbs_err_i,
    input [num_slaves-1:0]     wbs_rty_i);
   parameter slave_sel_bits = num_slaves > 1 ? $clog2(num_slaves) : 1;
   reg  			 wbm_err;
   wire [slave_sel_bits-1:0] 	 slave_sel;
   wire [num_slaves-1:0] 	 match;
   genvar 			 idx;
   generate
      for(idx=0; idx<num_slaves ; idx=idx+1) begin : addr_match
	 assign match[idx] = (wbm_adr_i & MATCH_MASK[idx*aw+:aw]) == MATCH_ADDR[idx*aw+:aw];
      end
   endgenerate
   function [slave_sel_bits-1:0] ff1;
      input [num_slaves-1:0] in;
      integer 		     i;
      begin
	 ff1 = 0;
	 for (i = num_slaves-1; i >= 0; i=i-1) begin
	    if (in[i])
	      ff1 = i;
	 end
      end
   endfunction
   assign slave_sel = ff1(match);
   always @(posedge wb_clk_i)
     wbm_err <= wbm_cyc_i & !(|match);
   assign wbs_adr_o = {num_slaves{wbm_adr_i}};
   assign wbs_dat_o = {num_slaves{wbm_dat_i}};
   assign wbs_sel_o = {num_slaves{wbm_sel_i}};
   assign wbs_we_o  = {num_slaves{wbm_we_i}};
   assign wbs_cyc_o = match & (wbm_cyc_i << slave_sel);
   assign wbs_stb_o = {num_slaves{wbm_stb_i}};
   assign wbs_cti_o = {num_slaves{wbm_cti_i}};
   assign wbs_bte_o = {num_slaves{wbm_bte_i}};
   assign wbm_dat_o = wbs_dat_i[slave_sel*dw+:dw];
   assign wbm_ack_o = wbs_ack_i[slave_sel];
   assign wbm_err_o = wbs_err_i[slave_sel] | wbm_err;
   assign wbm_rty_o = wbs_rty_i[slave_sel];
endmodule