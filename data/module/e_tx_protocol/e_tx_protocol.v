module e_tx_protocol (
   e_tx_rd_wait, e_tx_wr_wait, e_tx_ack, txframe_p, txdata_p,
   reset, e_tx_access, e_tx_write, e_tx_datamode, e_tx_ctrlmode,
   e_tx_dstaddr, e_tx_srcaddr, e_tx_data, txlclk_p, tx_rd_wait,
   tx_wr_wait
   );
   input         reset;
   input         e_tx_access;
   input         e_tx_write;
   input [1:0]   e_tx_datamode;
   input [3:0]   e_tx_ctrlmode;
   input [31:0]  e_tx_dstaddr;
   input [31:0]  e_tx_srcaddr;
   input [31:0]  e_tx_data;
   output        e_tx_rd_wait;
   output        e_tx_wr_wait;
   output        e_tx_ack;
   input         txlclk_p; 
   output [7:0]  txframe_p;
   output [63:0] txdata_p;
   input         tx_rd_wait;  
   input         tx_wr_wait;  
   reg           e_tx_ack;  
   reg [7:0]     txframe_p;
   reg [63:0]    txdata_p;
   always @( posedge txlclk_p or posedge reset ) begin
      if( reset ) begin
         e_tx_ack    <= 1'b0;
         txframe_p   <= 'd0;
         txdata_p    <= 'd0;
      end else begin
         if( e_tx_access & ~e_tx_ack ) begin
            e_tx_ack  <= 1'b1;
            txframe_p <= 8'h3F;
            txdata_p  <=
               { 8'd0,  
                 8'd0,
                 ~e_tx_write, 7'd0,   
                 e_tx_ctrlmode, e_tx_dstaddr[31:28], 
                 e_tx_dstaddr[27:4],  
                 e_tx_dstaddr[3:0], e_tx_datamode, e_tx_write, e_tx_access 
                 };
         end else if( e_tx_ack ) begin 
            e_tx_ack  <= 1'b0;
            txframe_p <= 8'hFF;
            txdata_p  <= { e_tx_data, e_tx_srcaddr };
         end else begin
            e_tx_ack    <= 1'b0;
            txframe_p <= 8'h00;
            txdata_p  <= 64'd0;
         end
      end 
   end 
   reg     rd_wait_sync;
   reg     wr_wait_sync;
   reg     e_tx_rd_wait;
   reg     e_tx_wr_wait;
   always @( posedge txlclk_p ) begin
      rd_wait_sync <= tx_rd_wait;
      e_tx_rd_wait <= rd_wait_sync;
      wr_wait_sync <= tx_wr_wait;
      e_tx_wr_wait <= wr_wait_sync;
   end
endmodule