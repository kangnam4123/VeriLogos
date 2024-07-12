module hbi_dout_stage 
   (
    input	       hb_clk,            
    input [31:0]       hb_regs_dout,      
    input [31:0]       hb_rcache_dout,    
    input [31:0]       hdat_out_crt_vga,  
    input [31:0]       draw_engine_a_dout,
    input [31:0]       draw_engine_reg,   
    input	       cs_global_regs_n,  
    input	       cs_hbi_regs_n,     
    input              cs_xyw_a_n,        
    input	       decoder_cs_windows_n, 
    input	       hb_lached_rdwr,    
    input	       hbi_addr_in,       
    input [3:0]        hb_byte_ens,       
    input	       irdy_n,            
    input	       sys_reset_n,       
    input	       trdy_n,            
    input [31:0]       perph_rd_dbus,     
    input	       cs_eprom_n,        
    input	       cs_dac_space_n,    
    input	       cs_vga_space_n,    
					      input [2:0]  swizzler_ctrl,
    input	       any_trdy_async,    
    input [31:0]       pci_ad_out,        
    input	       pci_ad_oe,         
    input [3:0]        c_be_out,
    output reg [31:0]  blkbird_dout,      
    output reg	       par32              
    );
  reg 		 pci_ad_oe_reg;
  reg [31:0] 	 hb_data_swizzled;
  wire [31:0] 	 hb_regblock_dout;
  wire [31:0] 	 hb_read_data;
  wire [7:0] 	 hb_dat_b3, hb_dat_b2, hb_dat_b1, hb_dat_b0; 
  wire [7:0] 	 hb_dat_b7, hb_dat_b6, hb_dat_b5, hb_dat_b4; 
  wire		 be_par32;
  wire		 bkbrd_par32;
  wire		 lower_level_parity32;
  wire 		 be_out_par32;
  wire 		 pci_master_par32;
  parameter	 
		 READ    = 1'b0,
		 WRITE   = 1'b1;
  assign  hb_read_data =
	  (!cs_eprom_n || !cs_dac_space_n) ? perph_rd_dbus :
	  (!cs_vga_space_n || !cs_global_regs_n) ?  hdat_out_crt_vga : 
	  (!cs_hbi_regs_n) ? hb_regs_dout :         
	  (!decoder_cs_windows_n) ? hb_rcache_dout :
	  (!cs_xyw_a_n) ? draw_engine_a_dout :
	  draw_engine_reg;
  assign  hb_dat_b3 = 
      (swizzler_ctrl[0]) ?
      {hb_read_data[24], hb_read_data[25], hb_read_data[26],
       hb_read_data[27], hb_read_data[28], hb_read_data[29],
       hb_read_data[30], hb_read_data[31]}                 :
	  hb_read_data[31:24];
   assign hb_dat_b2 =
      (swizzler_ctrl[0]) ?
      {hb_read_data[16], hb_read_data[17], hb_read_data[18],
       hb_read_data[19], hb_read_data[20], hb_read_data[21],
       hb_read_data[22], hb_read_data[23]}                 :
	  hb_read_data[23:16];
   assign hb_dat_b1 =
      (swizzler_ctrl[0]) ?
      {hb_read_data[8],  hb_read_data[9],  hb_read_data[10],
       hb_read_data[11], hb_read_data[12] ,hb_read_data[13],
       hb_read_data[14], hb_read_data[15]}                 :
	  hb_read_data[15:8];
   assign hb_dat_b0 =
      (swizzler_ctrl[0]) ?
      {hb_read_data[0], hb_read_data[1], hb_read_data[2],
       hb_read_data[3], hb_read_data[4], hb_read_data[5],
       hb_read_data[6],hb_read_data[7]}                    :
	  hb_read_data[7:0];
  always @*
    case (swizzler_ctrl[2:1])
      2'b00:
	hb_data_swizzled = { hb_dat_b3, hb_dat_b2, hb_dat_b1, hb_dat_b0};
      2'b01:
	hb_data_swizzled = { hb_dat_b2, hb_dat_b3, hb_dat_b0, hb_dat_b1};
      2'b10:
	hb_data_swizzled = { hb_dat_b1, hb_dat_b0, hb_dat_b3, hb_dat_b2};
      2'b11:
	hb_data_swizzled = { hb_dat_b0, hb_dat_b1, hb_dat_b2, hb_dat_b3};
    endcase 
  always @ (posedge hb_clk) begin
    if (any_trdy_async && (trdy_n || (!trdy_n && !irdy_n)))
      blkbird_dout <= hb_data_swizzled;
    else if (pci_ad_oe)
      blkbird_dout <= pci_ad_out;
  end
   always @(posedge hb_clk) pci_ad_oe_reg <= pci_ad_oe;
   assign be_par32 = ^hb_byte_ens[3:0];
   assign be_out_par32 = ^c_be_out[3:0]; 
   assign bkbrd_par32 = ^blkbird_dout;
   assign lower_level_parity32 = bkbrd_par32 ^ be_par32;
   assign pci_master_par32 = bkbrd_par32 ^ be_out_par32;
  always @(posedge hb_clk or negedge sys_reset_n) begin
    if (!sys_reset_n) begin
      par32 <= 1'b0;
    end else if (pci_ad_oe_reg) begin
      par32 <= pci_master_par32;
    end else if (!trdy_n && !irdy_n) begin
      par32 <= lower_level_parity32; 
    end 
  end
endmodule