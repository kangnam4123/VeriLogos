module clk_sel
    (
     input         h_reset_n,
     input         t_crt_clk,
     input         m_sr01_b3,       
     input         a_ar10_b6,       
     input         final_sh_ld,
     input 	   pre_load,        
     input 	   cclk_en,         
     output        sel_sh_ld,       
     output reg    sel_sh_ld_pulse, 
     output reg    dclk_en,         
     output reg    pclk_en          
     );
  reg [1:0] clk_sel_reg;
  reg 	    crt_2_clk_ff;   
  reg [3:0] crt_4_clk_ff;
  reg 	    sel_sh_ld_pulse_store;
  reg 	    int_sh_ld_ff;   
  reg 	    sh_ld_ctl_ff;   
  reg 	    sel_sh_ld_reg;
  wire 	    sh_ld;          
  wire 	    dclk_by_2 = m_sr01_b3;
  wire 	    crt_2_clk_ff_din;
  wire 	    crt_4_clk_ff_din;
  wire [1:0] clk_sel_ctl = { a_ar10_b6, dclk_by_2 } ;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if (!h_reset_n)     dclk_en <= 1'b0;
    else if (dclk_by_2) dclk_en <= ~dclk_en;
    else                dclk_en <= 1'b1;
  always @(posedge t_crt_clk) 
    if (~crt_2_clk_ff & ~crt_4_clk_ff[1]) clk_sel_reg <= clk_sel_ctl;
  always @*
    case (clk_sel_reg)
      2'd0: pclk_en = 1'b1;
      2'd1: pclk_en = crt_2_clk_ff;
      2'd2: pclk_en = crt_2_clk_ff;
      2'd3: pclk_en = crt_4_clk_ff[3];
    endcase 
  always @( posedge t_crt_clk or negedge h_reset_n )
    if(~h_reset_n)
      int_sh_ld_ff <= 1'b0;
    else
      int_sh_ld_ff <= final_sh_ld;
  always @(posedge t_crt_clk or negedge h_reset_n)
    if(~h_reset_n)
      sh_ld_ctl_ff <= 1'b0;
    else if (pre_load & ~final_sh_ld & cclk_en)
      sh_ld_ctl_ff <= dclk_by_2;
  assign     sh_ld = sh_ld_ctl_ff ? (int_sh_ld_ff & final_sh_ld) : final_sh_ld;
  always @( posedge t_crt_clk or negedge h_reset_n )
    if(~h_reset_n)
      crt_2_clk_ff <= 1'b0;
    else
      crt_2_clk_ff <= ~crt_2_clk_ff;
  always @( posedge t_crt_clk or negedge h_reset_n )
    if(~h_reset_n)
      crt_4_clk_ff <= 3'b0;
    else
      begin
	crt_4_clk_ff[0] <= ~|crt_4_clk_ff[2:0];
	crt_4_clk_ff[1] <= crt_4_clk_ff[0];
	crt_4_clk_ff[2] <= crt_4_clk_ff[1];
	crt_4_clk_ff[3] <= crt_4_clk_ff[2];
      end
  always @( posedge t_crt_clk or negedge h_reset_n )
    if(~h_reset_n) begin
      sel_sh_ld_reg <= 1'b0;
      sel_sh_ld_pulse <= 1'b0;
      sel_sh_ld_pulse_store <= 1'b0;
    end else begin
      if (pclk_en) sel_sh_ld_reg <= 1'b0;
      else if (final_sh_ld)  sel_sh_ld_reg <= 1'b1;
      if (final_sh_ld & ~sel_sh_ld_pulse_store) begin
	sel_sh_ld_pulse_store <= 1'b1;
	sel_sh_ld_pulse <= 1'b1;
      end else begin
	sel_sh_ld_pulse <= 1'b0;
	if (~final_sh_ld) sel_sh_ld_pulse_store <= 1'b0;
      end
    end
  assign sel_sh_ld = final_sh_ld | sel_sh_ld_reg;
endmodule