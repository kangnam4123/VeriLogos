module latch_ID_EX
	#(
	parameter B=32,W=5
   )
	(
	input wire clk,
	input wire reset,
	inout wire ena,
	input wire flush,
	input wire [B-1:0] pc_next_in,
	input wire [B-1:0] r_data1_in,
	input wire [B-1:0] r_data2_in,
	input wire [B-1:0] sign_ext_in,
	input wire [W-1:0] inst_25_21_in,
	input wire [W-1:0] inst_20_16_in,
	input wire [W-1:0] inst_15_11_in,
	output wire [B-1:0] pc_next_out,
	output wire [B-1:0] r_data1_out,
	output wire [B-1:0] r_data2_out,
	output wire [B-1:0] sign_ext_out,
	output wire [W-1:0] inst_25_21_out,
	output wire [W-1:0] inst_20_16_out,
	output wire [W-1:0] inst_15_11_out,
	input wire wb_RegWrite_in,
	input wire wb_MemtoReg_in,
	input wire m_MemWrite_in,
	input wire ex_RegDst_in,
	input wire [5:0] ex_ALUOp_in,
	input wire ex_ALUSrc_in,
	input wire [5:0] opcode_in,
	output wire wb_RegWrite_out,
	output wire wb_MemtoReg_out,
	output wire m_MemWrite_out,
	output wire ex_RegDst_out,
	output wire [5:0] ex_ALUOp_out,
	output wire ex_ALUSrc_out,
	output wire [5:0] opcode_out
	);
	reg [B-1:0] pc_next_reg;
	reg signed [B-1:0] r_data1_reg;
	reg signed [B-1:0] r_data2_reg;
	reg [B-1:0] sign_ext_reg;
	reg [W-1:0] inst_25_21_reg;
	reg [W-1:0] inst_20_16_reg;
	reg [W-1:0] inst_15_11_reg;
	reg wb_RegWrite_reg;
	reg wb_MemtoReg_reg;
	reg m_MemWrite_reg;
	reg ex_RegDst_reg;
	reg [5:0] ex_ALUOp_reg;
	reg ex_ALUSrc_reg;
	reg [5:0] opcode_reg;
	always @(posedge clk)
	begin
		if (reset)
			begin
				pc_next_reg <= 0;
				r_data1_reg <= 0;
				r_data2_reg <= 0;
				sign_ext_reg <= 0;
				inst_25_21_reg <= 5'b00000;
				inst_20_16_reg <= 5'b00000;
				inst_15_11_reg <= 5'b00000;
				wb_RegWrite_reg <= 0;
				wb_MemtoReg_reg <= 0;
				m_MemWrite_reg <= 0;
				ex_RegDst_reg <= 0;
				ex_ALUOp_reg <= 0;
				ex_ALUSrc_reg <= 0;
				opcode_reg <= 0;
			end
		else
			if(ena==1'b1)
				if (flush)
					begin
					pc_next_reg <= 0;
					r_data1_reg <= 0;
					r_data2_reg <= 0;
					sign_ext_reg <= 0;
					inst_25_21_reg <= 5'b00000;
					inst_20_16_reg <= 5'b00000;
					inst_15_11_reg <= 5'b00000;
					wb_RegWrite_reg <= 0;
					wb_MemtoReg_reg <= 0;
					m_MemWrite_reg <= 0;
					ex_RegDst_reg <= 0;
					ex_ALUOp_reg <= 0;
					ex_ALUSrc_reg <= 0;
					opcode_reg <= 0;
					end
				else
					begin
					pc_next_reg <= pc_next_in;
					r_data1_reg <= r_data1_in;
					r_data2_reg <= r_data2_in;
					sign_ext_reg <= sign_ext_in;
					inst_25_21_reg <= inst_25_21_in;
					inst_20_16_reg <= inst_20_16_in;
					inst_15_11_reg <= inst_15_11_in;
					wb_RegWrite_reg <= wb_RegWrite_in;
					wb_MemtoReg_reg <= wb_MemtoReg_in;
					m_MemWrite_reg <= m_MemWrite_in;
					ex_RegDst_reg <= ex_RegDst_in;
					ex_ALUOp_reg <= ex_ALUOp_in;
					ex_ALUSrc_reg <= ex_ALUSrc_in;
					opcode_reg <= opcode_in;
					end
	end
	assign pc_next_out = pc_next_reg;
	assign r_data1_out = r_data1_reg;
	assign r_data2_out = r_data2_reg;
	assign sign_ext_out = sign_ext_reg;
	assign inst_25_21_out = inst_25_21_reg;
	assign inst_20_16_out = inst_20_16_reg;
	assign inst_15_11_out = inst_15_11_reg;
	assign wb_RegWrite_out = wb_RegWrite_reg;
	assign wb_MemtoReg_out = wb_MemtoReg_reg;
	assign m_MemWrite_out = m_MemWrite_reg;
	assign ex_RegDst_out = ex_RegDst_reg;
	assign ex_ALUOp_out = ex_ALUOp_reg;
	assign ex_ALUSrc_out = ex_ALUSrc_reg;
	assign opcode_out = opcode_reg;
endmodule