module mig_7series_v2_0_qdr_rld_of_pre_fifo #
  (
   parameter TCQ   = 100,             
   parameter DEPTH = 4,               
   parameter WIDTH = 32               
   )
  (
   input              clk,            
   input              rst,            
   input              full_in,        
   input              wr_en_in,       
   input [WIDTH-1:0]  d_in,           
   output             wr_en_out,      
   output [WIDTH-1:0] d_out           
   );
  localparam PTR_BITS 
             = (DEPTH == 2) ? 1 : 
               ((DEPTH == 3) || (DEPTH == 4)) ? 2 : 
               (((DEPTH == 5) || (DEPTH == 6) || 
                 (DEPTH == 7) || (DEPTH == 8)) ? 3 : 'bx);
  integer i;
  reg [WIDTH-1:0]     mem[0:DEPTH-1];
  reg [6:0]          my_empty ;
  reg [3:0]          my_full  ;
  reg [PTR_BITS-1:0] rd_ptr   ;
  reg [PTR_BITS-1:0] wr_ptr   ;
  wire [PTR_BITS-1:0] nxt_rd_ptr;
  wire [PTR_BITS-1:0] nxt_wr_ptr;
  wire [WIDTH-1:0]    mem_out;
  wire                wr_en;
  wire                wr_en_1;
  assign d_out = my_empty[0] ? d_in : mem_out;
  assign wr_en_out = !full_in && (!my_empty[1] || wr_en_in);
  assign wr_en = wr_en_in & (full_in ? !my_full[1] : !my_empty[2]);
  assign wr_en_1 = wr_en_in & (full_in ? !my_full[2] : !my_empty[4]);
  always @ (posedge clk)
    if (wr_en)
      mem[wr_ptr] <= #TCQ d_in;
  assign mem_out = mem[rd_ptr];
  assign nxt_rd_ptr = (rd_ptr + 1'b1)%DEPTH;
  always @ (posedge clk)
  begin
    if (rst)
      rd_ptr <= 'b0;
    else if ((!my_empty[6]) & (!full_in))
      rd_ptr <= nxt_rd_ptr;
  end
  always @ (posedge clk)
  begin
    if (rst)
      my_empty <= 7'b1111111;
    else if (my_empty[3] & !my_full[3] & full_in & wr_en_in)
      my_empty <= 7'b0000000;
    else if (!my_empty[3] & !my_full[3] & !full_in & !wr_en_in) begin
      my_empty[0] <= (nxt_rd_ptr == wr_ptr);
      my_empty[1] <= (nxt_rd_ptr == wr_ptr);
      my_empty[2] <= (nxt_rd_ptr == wr_ptr);
      my_empty[3] <= (nxt_rd_ptr == wr_ptr);
      my_empty[4] <= (nxt_rd_ptr == wr_ptr);
      my_empty[5] <= (nxt_rd_ptr == wr_ptr);
      my_empty[6] <= (nxt_rd_ptr == wr_ptr);
    end
  end
  assign nxt_wr_ptr = (wr_ptr + 1'b1)%DEPTH;
  always @ (posedge clk)
  begin
    if (rst)
      wr_ptr <= 'b0;
    else if (wr_en_1)
      wr_ptr <= nxt_wr_ptr;
  end
  always @ (posedge clk)
  begin
    if (rst)
      my_full <= 4'b0000;
    else if (!my_empty[5] & my_full[0] & !full_in & !wr_en_in)
      my_full <= 4'b0000;
    else if (!my_empty[5] & !my_full[0] & full_in & wr_en_in) begin
      my_full[0] <= (nxt_wr_ptr == rd_ptr);
      my_full[1] <= (nxt_wr_ptr == rd_ptr);
      my_full[2] <= (nxt_wr_ptr == rd_ptr);
      my_full[3] <= (nxt_wr_ptr == rd_ptr);
    end
  end
endmodule