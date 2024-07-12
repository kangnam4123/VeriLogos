module bus_clk_bridge
(
   input                 sys_clk_i     ,  
   input                 sys_rstn_i    ,  
   input      [ 32-1: 0] sys_addr_i    ,  
   input      [ 32-1: 0] sys_wdata_i   ,  
   input      [  4-1: 0] sys_sel_i     ,  
   input                 sys_wen_i     ,  
   input                 sys_ren_i     ,  
   output     [ 32-1: 0] sys_rdata_o   ,  
   output                sys_err_o     ,  
   output                sys_ack_o     ,  
   input                 clk_i         ,  
   input                 rstn_i        ,  
   output reg [ 32-1: 0] addr_o        ,  
   output reg [ 32-1: 0] wdata_o       ,  
   output                wen_o         ,  
   output                ren_o         ,  
   input      [ 32-1: 0] rdata_i       ,  
   input                 err_i         ,  
   input                 ack_i            
);
reg            sys_rd    ;
reg            sys_wr    ;
reg            sys_do    ;
reg  [ 2-1: 0] sys_sync  ;
reg            sys_done  ;
reg            dst_do    ;
reg  [ 2-1: 0] dst_sync  ;
reg            dst_done  ;
always @(posedge sys_clk_i) begin
   if (sys_rstn_i == 1'b0) begin
      sys_rd   <= 1'b0 ;
      sys_wr   <= 1'b0 ;
      sys_do   <= 1'b0 ;
      sys_sync <= 2'h0 ;
      sys_done <= 1'b0 ;
   end 
   else begin
      if ((sys_do == sys_done) && (sys_wen_i || sys_ren_i)) begin
         addr_o  <= sys_addr_i    ;
         wdata_o <= sys_wdata_i   ;
         sys_rd  <= sys_ren_i     ;
         sys_wr  <= sys_wen_i     ;
         sys_do  <= !sys_do       ;
      end
      sys_sync <= {sys_sync[0], dst_done};
      sys_done <= sys_sync[1];
   end
end
always @(posedge clk_i) begin
   if (rstn_i == 1'b0) begin
      dst_do    <= 1'b0 ;
      dst_sync  <= 2'h0 ;
      dst_done  <= 1'b0 ;
   end
   else begin
      dst_sync <= {dst_sync[0], sys_do};
      dst_do   <= dst_sync[1];
      if (ack_i && (dst_do != dst_done))
         dst_done <= dst_do;
   end
end
assign ren_o = sys_rd && (dst_sync[1]^dst_do);
assign wen_o = sys_wr && (dst_sync[1]^dst_do);
assign sys_rdata_o = rdata_i                ;
assign sys_err_o   = err_i                  ;
assign sys_ack_o   = sys_done ^ sys_sync[1] ;
endmodule