module if_id_reg
#(
    parameter PC_DATA_WIDTH = 20,
    parameter INSTRUCTION_WIDTH = 32
)(
   input clk,    
   input rst_n,  
   input en,
   input stall,                                              
   input flush,                                              
   input [INSTRUCTION_WIDTH-1:0] inst_mem_data_in,           
   input [PC_DATA_WIDTH-1:0] pc_in,                          
   output reg [PC_DATA_WIDTH-1:0] new_pc_out,                
   output reg [INSTRUCTION_WIDTH-1:0] instruction_reg_out    
);
always@(posedge clk or negedge rst_n)begin
   if(!rst_n) begin
      new_pc_out <= 0;
      instruction_reg_out <= 0;
   end else if((!stall)&en)begin
      new_pc_out <= pc_in;
         instruction_reg_out <= inst_mem_data_in;
   end
end
endmodule