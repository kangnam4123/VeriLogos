module altpciexpav_stif_reg_fifo
#(
   parameter FIFO_DEPTH = 5,
   parameter DATA_WIDTH = 304
  )
  (
    input                         clk,
    input                         rstn,
    input                         srst,
    input                         wrreq,
    input                         rdreq,
    input  [DATA_WIDTH-1:0]       data,  
    output [DATA_WIDTH-1:0]       q,
    output reg [3:0]              fifo_count
   );
   reg  [DATA_WIDTH-1:0]          fifo_reg[FIFO_DEPTH-1:0];
   wire [FIFO_DEPTH-1:0]          fifo_wrreq;  
 always @(posedge clk or negedge rstn)
    begin
      if(~rstn)
        fifo_count <= 4'h0;
      else if (srst)
            fifo_count <= 4'h0;
         else if (rdreq & ~wrreq)
            fifo_count <= fifo_count - 1;
         else if(~rdreq & wrreq)
            fifo_count <= fifo_count + 1;
    end
generate
  genvar i;
  for(i=0; i< FIFO_DEPTH -1; i=i+1)
    begin: register_array
       assign fifo_wrreq[i] = wrreq & (fifo_count == i | (fifo_count == i + 1 & rdreq)) ;
       always @(posedge clk or negedge rstn)
         begin
           if(~rstn)
             fifo_reg[i] <= {DATA_WIDTH{1'b0}};
           else if (srst)
             fifo_reg[i] <= {DATA_WIDTH{1'b0}};
           else if(fifo_wrreq[i])
             fifo_reg[i] <= data;
           else if(rdreq)
             fifo_reg[i] <= fifo_reg[i+1];
         end
       end
  endgenerate
 assign fifo_wrreq[FIFO_DEPTH-1] = wrreq & (fifo_count == FIFO_DEPTH - 1 | (fifo_count == FIFO_DEPTH & rdreq)) ;    
 always @(posedge clk or negedge rstn)
  begin
    if(~rstn)
      fifo_reg[FIFO_DEPTH-1] <= {DATA_WIDTH{1'b0}};
    else if (srst)
       fifo_reg[FIFO_DEPTH-1] <= {DATA_WIDTH{1'b0}};
    else if(fifo_wrreq[FIFO_DEPTH-1])
      fifo_reg[FIFO_DEPTH-1] <= data;
  end
assign q = fifo_reg[0];
endmodule