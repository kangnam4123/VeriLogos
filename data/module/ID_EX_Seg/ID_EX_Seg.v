module ID_EX_Seg(
input Clk,
input stall,
input flush,
input [31:0]PC_Add,
input OverflowEn,
input[2:0] condition,
input Branch,
input[2:0] PC_write,
input[3:0] Mem_Byte_Write,
input[3:0] Rd_Write_Byte_en,
input MemWBSrc,
input Jump,
input ALUShiftSrc,
input [2:0]MemDataSrc,
input ALUSrcA,ALUSrcB,
input [3:0] ALUOp,
input [1:0] RegDst,
input ShiftAmountSrc,
input [1:0] ShiftOp,
input [31:0] OperandA,OperandB,
input [4:0]Rs,Rt,Rd,
input [31:0] Immediate32,
input [4:0]Shamt,
input BranchSel,
input [1:0] RtRead,
output reg [31:0]PC_Add_out,
output reg OverflowEn_out,
output reg[2:0] condition_out,
output reg Branch_out,
output reg[2:0] PC_write_out,
output reg[3:0] Mem_Byte_Write_out,
output reg[3:0] Rd_Write_Byte_en_out,
output reg MemWBSrc_out,
output reg Jump_out,
output reg ALUShiftSrc_out,
output reg [2:0]MemDataSrc_out,
output reg ALUSrcA_out,ALUSrcB_out,
output reg [3:0] ALUOp_out,
output reg [1:0] RegDst_out,
output reg ShiftAmountSrc_out,
output reg [1:0] ShiftOp_out,
output reg [31:0] OperandA_out,OperandB_out,
output reg [4:0] Rs_out,Rt_out,Rd_out,
output reg [31:0] Immediate32_out,
output reg [4:0]Shamt_out,
output reg BranchSel_out,
output reg [1:0] RtRead_out
);
always@(posedge Clk)
begin
if(flush)begin 
	PC_Add_out <= 32'h0;
	OverflowEn_out <= 1'b0;
	condition_out <= 3'b0;
	Branch_out <= 1'b0;
	PC_write_out <= 3'b0;
	Mem_Byte_Write_out <= 4'b0;
	Rd_Write_Byte_en_out <= 4'b0;
	MemWBSrc_out <= 1'b0;
	Jump_out <= 1'b0;
	ALUShiftSrc_out <= 1'b0;
	MemDataSrc_out <= 3'b0;
	ALUSrcA_out <= 1'b0;
	ALUSrcB_out <= 1'b0;
	ALUOp_out <= 4'b0;
	RegDst_out <= 2'b0;
	ShiftAmountSrc_out <= 1'b0;
	ShiftOp_out <= 2'b0;
	OperandA_out <= 32'b0;
	OperandB_out <= 32'b0;
	Rs_out <= 5'b0;
	Rt_out <= 5'b0;
	Rd_out <= 5'b0;
	Immediate32_out <= 32'b0;
	Shamt_out <= 5'b0;
	BranchSel_out <= 1'b0;
	RtRead_out <= 1'b0;
end
else if(~stall)
begin
	PC_Add_out <= PC_Add;
	OverflowEn_out <= OverflowEn;
	condition_out <= condition;
	Branch_out <= Branch;
	PC_write_out <= PC_write;
	Mem_Byte_Write_out <= Mem_Byte_Write;
	Rd_Write_Byte_en_out <= Rd_Write_Byte_en;
	MemWBSrc_out <= MemWBSrc;
	Jump_out <= Jump;
	ALUShiftSrc_out <= ALUShiftSrc;
	MemDataSrc_out <= MemDataSrc;
	ALUSrcA_out <= ALUSrcA;
	ALUSrcB_out <= ALUSrcB;
	ALUOp_out <= ALUOp;
	RegDst_out <= RegDst;
	ShiftAmountSrc_out <= ShiftAmountSrc;
	ShiftOp_out <= ShiftOp;
	OperandA_out <= OperandA;
	OperandB_out <= OperandB;
	Rs_out <= Rs;
	Rt_out <= Rt;
	Rd_out <= Rd;
	Immediate32_out <= Immediate32;
	Shamt_out <= Shamt;
	BranchSel_out <= BranchSel;
	RtRead_out <= RtRead;
end
end
endmodule