module ID_EX(
	clk,rst,
	id_a, id_b, id_td, id_d2, id_Aluc, id_WREG, id_WMEM, id_LW,id_instr,
	ex_a, ex_b, ex_td, ex_d2, ex_Aluc, ex_WREG, ex_WMEM, ex_LW,ex_instr
    );
	input clk,rst;
	input wire [31:0] id_a,id_b,id_d2,id_instr;
	input wire [4:0] id_td,id_Aluc;
	input wire id_WREG,id_WMEM,id_LW;
	output reg [31:0] ex_a,ex_b,ex_d2,ex_instr;
	output reg [4:0] ex_td,ex_Aluc;
	output reg ex_WREG,ex_WMEM,ex_LW;
	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			ex_a <= 0;
			ex_b <= 0;
			ex_d2 <= 0;
			ex_td <= 0;
			ex_Aluc <= 0;
			ex_WREG <= 0;
			ex_WMEM <= 0;
			ex_LW <= 0;
			ex_instr<=32'b100000;
		end
		else
		begin
			ex_a <= id_a;
			ex_b <= id_b;
			ex_d2 <= id_d2;
			ex_td <= id_td;
			ex_Aluc <= id_Aluc;
			ex_WREG <= id_WREG;
			ex_WMEM <= id_WMEM;
			ex_LW <= id_LW;
			ex_instr<=id_instr;
		end
	end
endmodule