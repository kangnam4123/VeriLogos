module spi_control # (
  parameter     CFG_FRAME_SIZE    = 4
)(  input         pclk,
                     input         presetn,
                     input         psel,
                     input         penable,
                     input         pwrite,
                     input  [6:0]  paddr,
                     input  [CFG_FRAME_SIZE-1:0] wr_data_in,
                     input         cfg_master,
                     input         rx_fifo_empty,
                     input         tx_fifo_empty,
                     output [CFG_FRAME_SIZE-1:0] tx_fifo_data,            
                     output        tx_fifo_write,           
                     output        tx_fifo_last,             
                     output        rx_fifo_read            
                );
reg tx_fifo_write_sig;
reg rx_fifo_read_sig;
reg tx_last_frame_sig;
assign tx_fifo_last   = tx_last_frame_sig;      
assign tx_fifo_data   = wr_data_in;
assign tx_fifo_write  = tx_fifo_write_sig;     
assign rx_fifo_read   = rx_fifo_read_sig;     
always @(*)
   begin
   rx_fifo_read_sig  = 1'b0;      
   tx_fifo_write_sig = 1'b0;      
   tx_last_frame_sig = 1'b0;      
   if (penable && psel)
      begin
      case (paddr) 
      6'h0C:	  
         begin
            if (pwrite)
               begin
                 tx_fifo_write_sig  = 1'b1;   
               end            
         end
      6'h08:    
         begin 
            if (~pwrite) 
            begin
                rx_fifo_read_sig = 1'b1;
            end
         end
      6'h28:    
        begin
          tx_fifo_write_sig  = 1'b1;   
          tx_last_frame_sig  = 1'b1;   
        end
      default:
         begin
         end
      endcase     
   end
end
endmodule