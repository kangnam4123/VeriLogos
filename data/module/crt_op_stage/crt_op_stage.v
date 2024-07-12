module crt_op_stage
    (
     input       h_reset_n,
     input       c_vde,            
     input       cr11_b4,          
     input       cr11_b5,          
     input       a_arx_b5,         
     input       m_sr01_b5,        
     input       vblank,           
     input       hblank,           
     input       cclk_en,          
     input       dclk_en,          
     input       hde,              
     input       c_ahde,	   
     input       int_crt_line_end, 
     input       t_crt_clk, 
     input       a_ar10_b0,
     input       vga_en,           
     output      c_t_crt_int,      
     output      c_attr_de,        
     output      c_t_cblank_n,     
     output      ade,              
     output      screen_off,
     output      dis_en_sta
     );
  reg 		 ade_ff;
  reg 		 intrpt_ff;
  reg 		 gated_hde_ff;
  reg 		 syn_cblank_ff;
  reg [2:0] 	 int_attr_de_d;
  reg [4:0] 	 int_cblank_d_dc;
  reg [2:0] 	 hde_d_cc;
  reg [1:0] 	 vde_syn_cclk;
  reg [1:0] 	 sr01_b5_syn_cclk;
  wire 		 comp_blank;
  reg [3:0] 	 comp_blank_d_cc;
  wire 		 int_cblank;
  wire 		 int_intrpt;
  wire 		 arx_b5_syn_cclk;
  wire 		 clr_intrpt_n = cr11_b4;
  wire 		 int_attr_de;
  reg [1:0] 	 sync1;
  wire [4:0] 	 h_blank_d_dc;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n) begin
      hde_d_cc <= 3'b0;
      sync1 <= 2'b0;
      vde_syn_cclk <= 2'b0;
      sr01_b5_syn_cclk <= 2'b11;
      comp_blank_d_cc <= 4'b0;
    end else if (cclk_en) begin
      hde_d_cc <= {hde_d_cc[1:0], hde};
      sync1 <= {sync1[0], a_arx_b5};
      vde_syn_cclk <= {vde_syn_cclk[0], c_vde};
      sr01_b5_syn_cclk <= {sr01_b5_syn_cclk[0], (m_sr01_b5 | ~vga_en)};
      comp_blank_d_cc <= {comp_blank_d_cc[2:0], comp_blank};
    end
  assign arx_b5_syn_cclk = sync1[1];
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (~h_reset_n)   gated_hde_ff <=  1'b0;
    else if (dclk_en) gated_hde_ff <=  ( arx_b5_syn_cclk & hde_d_cc[2] );
  assign      int_attr_de = gated_hde_ff & vde_syn_cclk[1];
  assign      dis_en_sta = ~(hde_d_cc[2] & vde_syn_cclk[1]);
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n)   int_attr_de_d <= 3'b0;
    else if (dclk_en) int_attr_de_d <= {int_attr_de_d[1:0], int_attr_de};
  assign      c_attr_de = int_attr_de_d[2];
  assign      screen_off = sr01_b5_syn_cclk[1];
  assign      comp_blank = vblank | hblank;
  assign      int_cblank = sr01_b5_syn_cclk[1] | comp_blank_d_cc[3];
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n)   int_cblank_d_dc <= 5'b0;
    else if (dclk_en) int_cblank_d_dc <= {int_cblank_d_dc[3:0], int_cblank};
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n) syn_cblank_ff <= 1'b0;
    else           syn_cblank_ff <= int_cblank_d_dc[4];
  assign      c_t_cblank_n = ~syn_cblank_ff;
  assign      int_intrpt = ( intrpt_ff | (~c_vde) ) & cr11_b4;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)    intrpt_ff <= 1'b0;
    else if (cclk_en) intrpt_ff <= int_intrpt;
  assign      c_t_crt_int       = intrpt_ff;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (~h_reset_n)                      ade_ff <= 1'b0;
    else if (int_crt_line_end & cclk_en) ade_ff <= c_vde;
  assign      ade = ade_ff & c_ahde;
endmodule