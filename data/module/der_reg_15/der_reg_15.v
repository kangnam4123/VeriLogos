module der_reg_15
  (
   input 	     de_clk,      
		     de_rstn,     
   input 	     load_15,     
   input [12:0]      buf_ctrl_1,  
   input [31:0]      sorg_1,      
   input [31:0]      dorg_1,      
   input [11:0]      sptch_1,     
   input [11:0]      dptch_1,     
   input [3:0] 	     opc_1,       
   input [3:0] 	     rop_1,       
   input [4:0] 	     style_1,     
   input 	     nlst_1,      
   input [1:0] 	     apat_1,      
   input [2:0] 	     clp_1,       
   input [31:0]      fore_1,      
   input [31:0]      back_1,      
   input [3:0] 	     mask_1,      
   input [23:0]      de_key_1,    
   input [15:0]      alpha_1,     
   input [17:0]      acntrl_1,    
   input [1:0] 	     bc_lvl_1, 
   input [31:0]      xy0_1, 
   input [31:0]      xy1_1, 
   input [31:0]      xy2_1, 
   input [31:0]      xy3_1, 
   input [31:0]      xy4_1, 
   output reg [12:0] buf_ctrl_15, 
   output reg [31:0] sorg_15,     
   output reg [31:0] dorg_15,     
   output reg [11:0] sptch_15,    
   output reg [11:0] dptch_15,    
   output reg [3:0]  rop_15,      
   output reg [4:0]  style_15,    
   output reg 	     nlst_15,     
   output reg [1:0]  apat_15,     
   output reg [2:0]  clp_15,      
   output reg [31:0] fore_15,     
   output reg [31:0] back_15,     
   output reg [3:0]  mask_15,     
   output reg [23:0] de_key_15,   
   output reg [15:0] alpha_15,    
   output reg [17:0] acntrl_15,   
   output reg [1:0]  bc_lvl_15,
   output reg [3:0]  opc_15,      
   output reg [31:0] xy0_15, 
   output reg [31:0] xy1_15, 
   output reg [31:0] xy2_15, 
   output reg [31:0] xy3_15, 
   output reg [31:0] xy4_15  
   );
  always @(posedge de_clk or negedge de_rstn) begin
    if(!de_rstn) begin
      buf_ctrl_15  <= 13'b0;
      sorg_15      <= 32'b0;
      dorg_15      <= 32'b0;
      rop_15       <= 4'b0;
      style_15     <= 5'b0;
      nlst_15      <= 1'b0;
      apat_15      <= 2'b0;
      clp_15       <= 3'b0;
      bc_lvl_15    <= 2'b0;
      sptch_15     <= 12'b0;
      dptch_15     <= 12'b0;
      fore_15      <= 32'b0;
      back_15      <= 32'b0;
      mask_15      <= 4'b0;
      de_key_15    <= 24'b0;
      alpha_15     <= 16'b0;
      acntrl_15    <= 18'b0;
      opc_15       <= 4'b0;
      xy0_15	   <= 32'h0;
      xy1_15	   <= 32'h0;
      xy2_15	   <= 32'h0;
      xy3_15	   <= 32'h0;
      xy4_15	   <= 32'h0;
    end else if (load_15) begin
      buf_ctrl_15  <= buf_ctrl_1;
      sorg_15      <= sorg_1;
      dorg_15      <= dorg_1;
      rop_15       <= rop_1;
      style_15     <= style_1;
      nlst_15      <= nlst_1;
      apat_15      <= apat_1;
      clp_15       <= clp_1;
      bc_lvl_15    <= bc_lvl_1;
      sptch_15     <= sptch_1;
      dptch_15     <= dptch_1;
      fore_15      <= fore_1; 
      back_15      <= back_1;
      mask_15      <= mask_1;
      de_key_15    <= de_key_1;
      alpha_15     <= alpha_1;
      acntrl_15    <= acntrl_1;
      opc_15       <= opc_1;
      xy0_15	   <= xy0_1;  
      xy1_15	   <= xy1_1;  
      xy2_15	   <= xy2_1;  
      xy3_15	   <= xy3_1;  
      xy4_15	   <= xy4_1; 
    end
  end
endmodule