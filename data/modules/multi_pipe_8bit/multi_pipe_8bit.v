module multi_pipe_8bit#(
  parameter size = 8
)(
  clk,      
  rst_n,       
  a,       
  b, 
  en_in,
  en_out,      
  out    
);
  input clk;           
  input rst_n; 
  input en_in;      
  input [size-1:0] a;       
  input [size-1:0] b;       
  output reg en_out;  
  output reg [size*2-1:0] out;    
 
  reg [2:0] en_out_reg;
  always@(posedge clk or negedge rst_n)
    if(!rst_n)begin
      en_out_reg <= 'd0;             
      en_out     <= 'd0;                           
    end
    else begin
      en_out_reg <= {en_out_reg[1:0],en_in};            
      en_out     <= en_out_reg[2];                  
    end
 
  reg [7:0] a_reg;
  reg [7:0] b_reg;
  always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
      a_reg <= 'd0;
      a_reg <= 'd0;
    end
    else begin
      a_reg <= en_in ? a :'d0;
      b_reg <= en_in ? b :'d0;
    end
  
  wire [15:0] temp [size-1:0];
  assign temp[0] = b_reg[0]? {8'b0,a_reg} : 'd0;
  assign temp[1] = b_reg[1]? {7'b0,a_reg,1'b0} : 'd0;
  assign temp[2] = b_reg[2]? {6'b0,a_reg,2'b0} : 'd0;
  assign temp[3] = b_reg[3]? {5'b0,a_reg,3'b0} : 'd0;
  assign temp[4] = b_reg[4]? {4'b0,a_reg,4'b0} : 'd0;
  assign temp[5] = b_reg[5]? {3'b0,a_reg,5'b0} : 'd0;
  assign temp[6] = b_reg[6]? {2'b0,a_reg,6'b0} : 'd0;
  assign temp[7] = b_reg[7]? {1'b0,a_reg,7'b0} : 'd0; 
 
  reg [15:0] sum [3:0];//[size/2-1:1]
  always @(posedge clk or negedge rst_n) 
    if(!rst_n) begin
      sum[0]  <= 'd0;
      sum[1]  <= 'd0;
      sum[2]  <= 'd0;
      sum[3]  <= 'd0;
    end 
    else begin
      sum[0] <= temp[0] + temp[1];
      sum[1] <= temp[2] + temp[3];
      sum[2] <= temp[4] + temp[5];
      sum[3] <= temp[6] + temp[7];
    end

  reg [15:0] out_reg;
  always @(posedge clk or negedge rst_n) 
    if(!rst_n)
      out_reg <= 'd0;
    else 
      out_reg <= sum[0] + sum[1] + sum[2] + sum[3];

  always @(posedge clk or negedge rst_n) 
    if(!rst_n)
      out <= 'd0;
    else if(en_out_reg[2])
      out <= out_reg;
    else
      out <= 'd0;
  
endmodule
