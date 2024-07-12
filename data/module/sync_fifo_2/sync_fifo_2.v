module sync_fifo_2 #(
  parameter FD    = 16,               
  parameter DW    = 32                
)(
  input  wire           clk,          
  input  wire           clk7_en,      
  input  wire           rst,          
  input  wire [ DW-1:0] fifo_in,      
  output wire [ DW-1:0] fifo_out,     
  input  wire           fifo_wr_en,   
  input  wire           fifo_rd_en,   
  output wire           fifo_full,    
  output wire           fifo_empty    
);
function integer CLogB2;
  input [31:0] d;
  integer i;
begin
  i = d;
  for(CLogB2 = 0; i > 0; CLogB2 = CLogB2 + 1) i = i >> 1;
end
endfunction
localparam FCW = CLogB2(FD-1) + 1;
localparam FPW = CLogB2(FD-1);
reg  [FCW-1:0] fifo_cnt;
reg  [FPW-1:0] fifo_wp, fifo_rp;
reg  [ DW-1:0] fifo_mem [0:FD-1];
always @ (posedge clk or posedge rst) begin
  if (rst)
    fifo_wp <= #1 1'b0;
  else if (clk7_en) begin
    if (fifo_wr_en && !fifo_full)
      fifo_wp <= #1 fifo_wp + 1'b1;
  end
end
always @ (posedge clk) begin
  if (clk7_en) begin
    if (fifo_wr_en && !fifo_full) fifo_mem[fifo_wp] <= #1 fifo_in;
  end
end
always @ (posedge clk or posedge rst) begin
  if (rst)
    fifo_cnt <= #1 'd0;
  else if (clk7_en) begin
    if (fifo_rd_en && !fifo_wr_en && (fifo_cnt != 'd0))
      fifo_cnt <= #1 fifo_cnt - 'd1;
    else if (fifo_wr_en && !fifo_rd_en && (fifo_cnt != FD))
      fifo_cnt <= #1 fifo_cnt + 'd1;
  end
end
assign fifo_full  = (fifo_cnt == (FD));
assign fifo_empty = (fifo_cnt == 'd0);
always @ (posedge clk or posedge rst) begin
  if (rst)
    fifo_rp <= #1 1'b0;
  else if (clk7_en) begin
    if (fifo_rd_en && !fifo_empty)
      fifo_rp <= #1 fifo_rp + 1'b1;
  end
end
assign fifo_out = fifo_mem[fifo_rp];
endmodule