module mig_7series_v4_0_axi_mc_fifo #
(
  parameter C_WIDTH  = 8,
  parameter C_AWIDTH = 4,
  parameter C_DEPTH  = 16
)
(
  input  wire               clk,       
  input  wire               rst,       
  input  wire               wr_en,     
  input  wire               rd_en,     
  input  wire [C_WIDTH-1:0] din,       
  output wire [C_WIDTH-1:0] dout,      
  output wire               a_full,
  output wire               full,      
  output wire               a_empty,
  output wire               empty      
);
localparam [C_AWIDTH:0] C_EMPTY = ~(0);
localparam [C_AWIDTH-1:0] C_EMPTY_PRE =  0;
localparam [C_AWIDTH-1:0] C_FULL  = C_DEPTH - 1;
localparam [C_AWIDTH-1:0] C_FULL_PRE  = C_DEPTH -2;
reg [C_WIDTH-1:0]  memory [C_DEPTH-1:0];
reg [C_AWIDTH:0] cnt_read;
reg [C_AWIDTH:0] next_cnt_read;
wire [C_AWIDTH:0] cnt_read_plus1;
wire [C_AWIDTH:0] cnt_read_minus1;
wire [C_AWIDTH-1:0] read_addr;
assign read_addr = cnt_read;
assign dout  = memory[read_addr];
always @(posedge clk) begin : BLKSRL
integer i;
  if (wr_en) begin
    for (i = 0; i < C_DEPTH-1; i = i + 1) begin
      memory[i+1] <= memory[i];
    end
    memory[0] <= din;
  end
end
always @(posedge clk) begin
  if (rst) cnt_read <= C_EMPTY;
  else cnt_read <= next_cnt_read;
end
assign cnt_read_plus1 = cnt_read + 1'b1;
assign cnt_read_minus1 = cnt_read - 1'b1;
always @(*) begin
  next_cnt_read = cnt_read;
  if ( wr_en & !rd_en) next_cnt_read = cnt_read_plus1;
  else if (!wr_en &  rd_en) next_cnt_read = cnt_read_minus1;
end
assign full  = (cnt_read == C_FULL);
assign empty = (cnt_read == C_EMPTY);
assign a_full  = (cnt_read == C_FULL_PRE);
assign a_empty = (cnt_read == C_EMPTY_PRE);
endmodule