module latch_EX_MEM
	#(
	parameter B=32, W=5
   )
	(
	input wire clk,
	input wire reset,
	inout wire ena,
	input wire [B-1:0] alu_result_in,
	input wire [B-1:0] r_data2_in,
	input wire [W-1:0] mux_RegDst_in,
	output wire [B-1:0]alu_result_out,
	output wire [B-1:0]r_data2_out,
	output wire [W-1:0]mux_RegDst_out,
	input wire wb_RegWrite_in,
	input wire wb_MemtoReg_in,
	input wire m_MemWrite_in,
	input [5:0] opcode_in,
	output wire wb_RegWrite_out,
	output wire wb_MemtoReg_out,
	output wire m_MemWrite_out,
	output wire [5:0] opcode_out
	);
	reg [B-1:0] alu_result_reg;
	reg [B-1:0] r_data2_reg;
	reg [W-1:0] mux_RegDst_reg;
	reg wb_RegWrite_reg;
	reg wb_MemtoReg_reg;
	reg m_MemWrite_reg;
	reg [5:0] opcode_reg;
	always @(posedge clk)
	begin
		if (reset)
		begin
			alu_result_reg <= 0;
			r_data2_reg <= 0;
			mux_RegDst_reg <= 0;
			wb_RegWrite_reg <= 0;
			wb_MemtoReg_reg <= 0;
			m_MemWrite_reg <= 0;
			opcode_reg <= 0;
		end
		else
			if(ena==1'b1)
			begin
				alu_result_reg <= alu_result_in;
				r_data2_reg <= r_data2_in;
				mux_RegDst_reg <= mux_RegDst_in;
				wb_RegWrite_reg <= wb_RegWrite_in;
				wb_MemtoReg_reg <= wb_MemtoReg_in;
				m_MemWrite_reg <= m_MemWrite_in;
				opcode_reg <= opcode_in;
			end
	end
	assign alu_result_out = alu_result_reg;
	assign r_data2_out = r_data2_reg;
	assign mux_RegDst_out = mux_RegDst_reg;
	assign wb_RegWrite_out = wb_RegWrite_reg;
	assign wb_MemtoReg_out = wb_MemtoReg_reg;
	assign m_MemWrite_out = m_MemWrite_reg;
	assign opcode_out = opcode_reg;
endmodule