module spi_fifo(   pclk,           
                   presetn,        
                   fiforst,
                   data_in,       
                   flag_in,       
                   data_out,      
                   flag_out,      
                   read_in,       
                   write_in,      
                   full_out,      
                   empty_out,     
                   full_next_out, 
                   empty_next_out,
                   overflow_out,  
                   fifo_count
                );
parameter CFG_FRAME_SIZE = 4;       
parameter FIFO_DEPTH = 4;       
input pclk;
input presetn;
input fiforst;
input [CFG_FRAME_SIZE-1:0] data_in;
input read_in;
input write_in;
input flag_in;
output [CFG_FRAME_SIZE-1:0] data_out;
output empty_out;
output full_out;
output empty_next_out;
output full_next_out;
output overflow_out;
output flag_out;
output [5:0] fifo_count;
reg [4:0] rd_pointer_d; 
reg [4:0] rd_pointer_q;        
reg [4:0] wr_pointer_d;
reg [4:0] wr_pointer_q;        
reg [5:0] counter_d;
reg [5:0] counter_q;           
reg [CFG_FRAME_SIZE:0] fifo_mem_d[0:FIFO_DEPTH-1];    
reg [CFG_FRAME_SIZE:0] fifo_mem_q[0:FIFO_DEPTH-1];
reg [CFG_FRAME_SIZE:0] data_out_dx;
reg [CFG_FRAME_SIZE:0] data_out_d;
reg full_out;       
reg empty_out;     
reg full_next_out;  
reg empty_next_out; 
wire [CFG_FRAME_SIZE-1:0]  data_out  = data_out_d[CFG_FRAME_SIZE-1:0];
wire                   flag_out  = data_out_d[CFG_FRAME_SIZE];
assign overflow_out = (write_in && (counter_q == FIFO_DEPTH));        
integer i;
always @(posedge pclk)
 begin  
   for (i=0; i<FIFO_DEPTH; i=i+1)
      begin
         fifo_mem_q[i] <= fifo_mem_d[i];
      end
 end
always @(posedge pclk or negedge presetn)
   begin
   if (~presetn)
     begin
       rd_pointer_q   <= 0;
       wr_pointer_q   <= 0;
       counter_q      <= 0;
       full_out       <= 0;
       empty_out      <= 1;
       full_next_out  <= 0;
       empty_next_out <= 0;
     end
   else
     begin
       rd_pointer_q   <= rd_pointer_d;
       wr_pointer_q   <= wr_pointer_d;
       counter_q      <= counter_d;
       full_out       <= (counter_d == FIFO_DEPTH); 
       empty_out      <= (counter_d == 0);
       full_next_out  <= (counter_q == FIFO_DEPTH-1);
       empty_next_out <= (counter_q == 1);
     end
   end
integer j;
always @(*)
begin  
   for (j=0; j<FIFO_DEPTH; j=j+1)    
      begin
         fifo_mem_d[j] = fifo_mem_q[j];
      end
   if (write_in)
      begin
        if (counter_q != FIFO_DEPTH)
          begin
          fifo_mem_d[wr_pointer_q[4:0]][CFG_FRAME_SIZE-1:0] = data_in[CFG_FRAME_SIZE-1:0];
          fifo_mem_d[wr_pointer_q[4:0]][CFG_FRAME_SIZE] = flag_in;
          end
      end
   data_out_dx = fifo_mem_q[rd_pointer_q[4:0]];
end
always @(*)
  begin
     data_out_d = data_out_dx[CFG_FRAME_SIZE:0];
     if (counter_q == 0) data_out_d[CFG_FRAME_SIZE] = 1'b0;
  end
always @(*)
   begin
     if (fiforst==1'b1)
     begin
        wr_pointer_d  = 5'b00000;
        rd_pointer_d  = 5'b00000;
        counter_d     = 6'b000000;
     end 
     else
     begin
       counter_d    = counter_q;
       rd_pointer_d = rd_pointer_q;
       wr_pointer_d = wr_pointer_q;
      if (read_in)
      begin
         if (counter_q != 0)   
         begin
            if (~write_in) 
               begin 
                  counter_d = counter_q - 1'b1;
               end
            if (rd_pointer_q == FIFO_DEPTH - 1)
              rd_pointer_d = 5'b00000;
            else   
              rd_pointer_d = rd_pointer_q + 1'b1; 
         end
      end 
      if (write_in)
      begin
         if (counter_q != FIFO_DEPTH) 
         begin
           if (~read_in)
            begin
               counter_d =  counter_q + 1'b1;
            end
            if (wr_pointer_q == FIFO_DEPTH-1)
              wr_pointer_d = 5'b00000;
            else
              wr_pointer_d = wr_pointer_q + 1'b1;
           end 
         end
     end
   end
wire [5:0] fifo_count = counter_q;
endmodule