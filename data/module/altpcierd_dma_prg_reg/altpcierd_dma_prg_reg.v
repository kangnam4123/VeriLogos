module altpcierd_dma_prg_reg #(
   parameter RC_64BITS_ADDR = 0,
   parameter AVALON_ST_128  = 0   )
   (
   input          clk_in,
   input          rstn,
   input          dma_prg_wrena,
   input[31:0]    dma_prg_wrdata,
   input[3:0]     dma_prg_addr,
   output reg [31:0] dma_prg_rddata,
   output reg [15:0] dt_rc_last,        
   output reg        dt_rc_last_sync,   
   output reg  [15:0] dt_size,          
   output reg  [63:0] dt_base_rc,       
   output reg         dt_eplast_ena,    
   output reg         dt_msi,           
   output reg         dt_3dw_rcadd,     
   output reg  [4:0]  app_msi_num,      
   output reg  [2:0]  app_msi_tc ,
   output reg         init              
   );
   localparam EP_ADDR_DW0 = 2'b00;
   localparam EP_ADDR_DW1 = 2'b01;
   localparam EP_ADDR_DW2 = 2'b10;
   localparam EP_ADDR_DW3 = 2'b11;
   reg        soft_dma_reset;
   reg        init_shift;
   reg [31:0] prg_reg_DW0;
   reg [31:0] prg_reg_DW1;
   reg [31:0] prg_reg_DW2;
   reg [31:0] prg_reg_DW3;
   reg        prg_reg_DW1_is_zero;
   reg        dma_prg_wrena_reg;
   reg[31:0]  dma_prg_wrdata_reg;
   reg[3:0]   dma_prg_addr_reg;
   always @ (negedge rstn or posedge clk_in) begin
      if (rstn==1'b0) begin
         soft_dma_reset <= 1'b1;
         init_shift     <= 1'b1;
         init           <= 1'b1;
         dma_prg_wrena_reg  <= 1'b0;
         dma_prg_wrdata_reg <= 32'h0;
         dma_prg_addr_reg   <= 4'h0;
      end
      else begin
          init              <= init_shift;
         dma_prg_wrena_reg  <= dma_prg_wrena;
         dma_prg_wrdata_reg <= dma_prg_wrdata;
         dma_prg_addr_reg   <= dma_prg_addr;
          soft_dma_reset <= (dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2]==EP_ADDR_DW0) & (dma_prg_wrdata_reg[15:0]==16'hFFFF);
          if (soft_dma_reset==1'b1)
              init_shift <= 1'b1;
          else if ((dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2]==EP_ADDR_DW3))
              init_shift <= 1'b0;
      end
   end
   always @ (posedge clk_in) begin
      if (soft_dma_reset == 1'b1) begin
         prg_reg_DW0         <= 32'h0;
         prg_reg_DW1         <= 32'h0;
         prg_reg_DW2         <= 32'h0;
         prg_reg_DW3         <= 32'h0;
         prg_reg_DW1_is_zero <= 1'b1;
         dt_size             <= 16'h0;
         dt_msi              <= 1'b0;
         dt_eplast_ena       <= 1'b0;
         app_msi_num         <= 5'h0;
         app_msi_tc          <= 3'h0;
         dt_rc_last_sync     <= 1'b0;
         dt_base_rc          <= 64'h0;
         dt_3dw_rcadd        <= 1'b0;
         dt_rc_last[15:0]    <= 16'h0;
         dma_prg_rddata      <= 32'h0;
      end
      else begin
          prg_reg_DW0 <= ((dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2] == EP_ADDR_DW0)) ? dma_prg_wrdata_reg : prg_reg_DW0; 
          prg_reg_DW1 <= ((dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2] == EP_ADDR_DW1)) ? dma_prg_wrdata_reg : prg_reg_DW1; 
          prg_reg_DW2 <= ((dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2] == EP_ADDR_DW2)) ? dma_prg_wrdata_reg : prg_reg_DW2; 
          prg_reg_DW3 <= ((dma_prg_wrena_reg==1'b1) & (dma_prg_addr_reg[3:2] == EP_ADDR_DW3)) ? dma_prg_wrdata_reg : prg_reg_DW3; 
          case (dma_prg_addr_reg[3:2])
              EP_ADDR_DW0: dma_prg_rddata <= prg_reg_DW0;
              EP_ADDR_DW1: dma_prg_rddata <= prg_reg_DW1;
              EP_ADDR_DW2: dma_prg_rddata <= prg_reg_DW2;
              EP_ADDR_DW3: dma_prg_rddata <= prg_reg_DW3;
          endcase
          dt_size           <= prg_reg_DW0[15:0]-1;
          dt_msi            <= prg_reg_DW0[17];
          dt_eplast_ena     <= prg_reg_DW0[18];
          app_msi_num       <= prg_reg_DW0[24:20];
          app_msi_tc        <= prg_reg_DW0[30:28];
          dt_rc_last_sync   <= prg_reg_DW0[31];
          dt_base_rc[63:32] <= prg_reg_DW1;
          dt_3dw_rcadd      <= (prg_reg_DW1==32'h0) ? 1'b1 : 1'b0;
          dt_base_rc[31:0]  <= prg_reg_DW2;
          dt_rc_last[15:0]  <= prg_reg_DW3[15:0];
      end
   end
endmodule