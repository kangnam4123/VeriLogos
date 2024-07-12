module ID_EX_9(
input Clk,
input stall,
input flush,
input [31:0]PC_4_ID,
input [5:0]op_ID,
input [2:0]Condition_ID,
input Branch_ID,
input MemWrite_ID,
input RegWrite_ID,
input MemRead_ID,
input Jump_ID,
input [1:0] ExResultSrc_ID,
input ALUSrcA_ID,
input ALUSrcB_ID,
input [3:0]ALUop_ID,
input [1:0]regdst_ID,
input ShiftAmountSrc_ID,
input [1:0]ShiftOp_ID,
input [31:0]A_in_ID,
input [31:0]B_in_ID,
input [4:0]Rs_ID,
input [4:0]Rt_ID,
input [4:0]Rd_ID,
input [31:0]Immediate32_ID,
input [4:0]Shamt_ID,
input loaduse_in,
output reg [31:0]PC_4_EX,
output reg [5:0]op_EX,
output reg [2:0]Condition_EX,
output reg Branch_EX,
output reg MemWrite_EX,
output reg RegWrite_EX,
output reg MemRead_EX,
output reg Jump_EX,
output reg [1:0]ExResultSrc_EX,
output reg ALUSrcA_EX,
output reg ALUSrcB_EX,
output reg [3:0]ALUop_EX,
output reg [1:0]regdst_EX,
output reg ShiftAmountSrc_EX,
output reg [1:0]ShiftOp_EX,
output reg [31:0]A_in_EX,
output reg [31:0]B_in_EX,
output reg [4:0]Rs_EX,
output reg [4:0]Rt_EX,
output reg [4:0]Rd_EX,
output reg [31:0]Immediate32_EX,
output reg [4:0]Shamt_EX,
output reg loaduse_out
);
initial
begin
PC_4_EX=32'b0;
op_EX=6'b0;
Condition_EX=3'b0;
Branch_EX=0;
MemWrite_EX=0;
RegWrite_EX=0;
MemRead_EX=0;
Jump_EX=0;
ExResultSrc_EX=2'b0;
ALUSrcA_EX=0;
ALUSrcB_EX=0;
ALUop_EX=4'b0;
regdst_EX=2'b0;
ShiftAmountSrc_EX=0;
ShiftOp_EX=2'b0;
A_in_EX=32'b0;
B_in_EX=32'b0;
Rs_EX=5'b0;
Rt_EX=5'b0;
Rd_EX=5'b0;
Immediate32_EX=32'b0;
Shamt_EX=5'b0;
loaduse_out = 0;
end
always @(negedge Clk)begin
	loaduse_out <= loaduse_in;
	if(flush)begin
		PC_4_EX=32'b0;
		op_EX=6'b0;
		Condition_EX=3'b0;
		Branch_EX=0;
		MemWrite_EX=0;
		RegWrite_EX=0;
		MemRead_EX=0;
		Jump_EX=0;
		ExResultSrc_EX=2'b0;
		ALUSrcA_EX=0;
		ALUSrcB_EX=0;
		ALUop_EX=4'b0;
		regdst_EX=2'b0;
		ShiftAmountSrc_EX=0;
		ShiftOp_EX=2'b0;
		A_in_EX=32'b0;
		B_in_EX=32'b0;
		Rs_EX=5'b0;
		Rt_EX=5'b0;
		Rd_EX=5'b0;
		Immediate32_EX=32'b0;
		Shamt_EX=5'b0;
	end
	else if(!stall)begin
		PC_4_EX <= PC_4_ID;
		op_EX <= op_ID;
		Condition_EX <= Condition_ID;
		Branch_EX <= Branch_ID;
		MemWrite_EX <= MemWrite_ID;
		RegWrite_EX <= RegWrite_ID;
		MemRead_EX <= MemRead_ID;
		Jump_EX <= Jump_ID;
		ExResultSrc_EX <= ExResultSrc_ID;
		ALUSrcA_EX <= ALUSrcA_ID;
		ALUSrcB_EX <= ALUSrcB_ID;
		ALUop_EX <= ALUop_ID;
		regdst_EX <= regdst_ID;
		ShiftAmountSrc_EX <= ShiftAmountSrc_ID;
		ShiftOp_EX <= ShiftOp_ID;
		A_in_EX <= A_in_ID;
		B_in_EX <= B_in_ID;
		Rs_EX <= Rs_ID;
		Rt_EX <= Rt_ID;
		Rd_EX <= Rd_ID;
		Immediate32_EX <= Immediate32_ID;
		Shamt_EX <= Shamt_ID;
	end
end
endmodule