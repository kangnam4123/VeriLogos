module fifo_full_block_1 (
   wr_fifo_full, wr_addr, wr_gray_pointer,
   reset, wr_clk, wr_rd_gray_pointer, wr_write
   );
   parameter AW   = 2; 
   input           reset;
   input           wr_clk;
   input [AW:0]    wr_rd_gray_pointer;
   input           wr_write;
   output           wr_fifo_full;
   output [AW-1:0]  wr_addr;
   output [AW:0]    wr_gray_pointer;
   reg [AW:0]      wr_gray_pointer;
   reg [AW:0]      wr_binary_pointer;
   reg             wr_fifo_full;
   wire            wr_fifo_full_next;
   wire [AW:0]     wr_gray_next;
   wire [AW:0]     wr_binary_next;
   always @(posedge wr_clk or posedge reset)
     if(reset)
       begin
	  wr_binary_pointer[AW:0]     <= {(AW+1){1'b0}};
	  wr_gray_pointer[AW:0]       <= {(AW+1){1'b0}};
       end
     else if(wr_write)
       begin
	  wr_binary_pointer[AW:0]     <= wr_binary_next[AW:0];	  
	  wr_gray_pointer[AW:0]       <= wr_gray_next[AW:0];	  
       end
   assign wr_addr[AW-1:0]       = wr_binary_pointer[AW-1:0];
   assign wr_binary_next[AW:0]  = wr_binary_pointer[AW:0] + 
				  {{(AW){1'b0}},wr_write};
   assign wr_gray_next[AW:0]    = {1'b0,wr_binary_next[AW:1]} ^ 
				  wr_binary_next[AW:0];
   assign wr_fifo_full_next =
			 (wr_gray_next[AW-2:0] == wr_rd_gray_pointer[AW-2:0]) &
			 (wr_gray_next[AW]     ^  wr_rd_gray_pointer[AW])     &
			 (wr_gray_next[AW-1]   ^  wr_rd_gray_pointer[AW-1]);
   always @ (posedge wr_clk or posedge reset)
     if(reset)
       wr_fifo_full <= 1'b0;
     else
       wr_fifo_full <=wr_fifo_full_next;
endmodule