module Controller_3(input [2:0] opcode, input [15:0] ac, input rst, output reg rd_mem, wr_mem, ac_src, ld_ac, pc_src, alu_add, alu_sub, ld_imm, halt);
	initial
	begin
		halt = 1'b0;
	end
	always@(opcode or rst)
	begin
		if(rst)
		begin
			halt = 1'b0;
		end
		rd_mem = 1'b0;
		wr_mem = 1'b0;
		ac_src = 1'b0;
		ld_ac = 1'b0;
		ld_imm = 1'b0;
		pc_src = 1'b0;
		alu_add = 1'b0;
		alu_sub = 1'b0;
		case(opcode)
			3'b000 : 
				begin
					if(halt == 1'b0)
					begin
						rd_mem = 1'b1;
						ac_src = 1'b1;
						ld_ac = 1'b1;
					end
				end
			3'b001 : 
				begin
					wr_mem = 1'b1;
				end
			3'b010 : 
				begin
					alu_add = 1'b1;
					ld_ac = 1'b1;
					rd_mem = 1'b1;
				end
			3'b011 : 
				begin
					alu_sub = 1'b1;
					ld_ac = 1'b1;
					rd_mem = 1'b1;
				end
			3'b100 : 
				begin
					pc_src = 1'b1;
				end
			3'b101 : 
				begin
					if(ac == 0)
					begin
						pc_src = 1'b1;
					end
				end
			3'b110 : 
				begin
					ld_imm = 1'b1;
					ld_ac = 1'b1;
				end
			3'b111 : 
				begin
					halt = 1'b1;
				end
		endcase
	end
endmodule