module debug_io_cnt #(
  parameter WIDTH = 1
)(        
  input rst,
  input clk,
  input [WIDTH-1:0] i_0,
  input [WIDTH-1:0] i_1,
  output reg [31:0] o_cnt_0,
  output reg [31:0] o_cnt_1,
  output reg        o_mismatch,
  output reg [15:0] o_mismatch_cnt
);            
always @(posedge clk or posedge rst) begin
  if(rst) begin
    o_cnt_0        <= '0;             
    o_cnt_1        <= '0;             
    o_mismatch_cnt <= '0;        
    o_mismatch <= '0;     
  end
  else begin       
    o_cnt_0    <= o_cnt_0 + i_0;        
    o_cnt_1    <= o_cnt_1 + i_1;        
    if(o_cnt_0 == o_cnt_1) o_mismatch_cnt <= '0;   
    else if(!(&o_mismatch_cnt)) o_mismatch_cnt <= o_mismatch_cnt + 1;
    o_mismatch <= |o_mismatch_cnt;
  end
end
endmodule