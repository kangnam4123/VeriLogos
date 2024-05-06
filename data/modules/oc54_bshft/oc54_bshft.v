module oc54_bshft (
	clk, ena, 
	a, b, cb, db,
	bp_a, bp_b, bp_ar, bp_br,
	l_na, sxm, seli, selo,
	t, asm, imm,
	result, co
	);
input         clk;
input         ena;
input  [39:0] a, b;           
input  [15:0] cb, db;         
input  [39:0] bp_ar, bp_br;   
input         bp_a, bp_b;     
input         sxm;            
input         l_na;           
input  [ 1:0] seli;           
input  [ 1:0] selo;           
input  [ 5:0] t;              
input  asm;            
input  imm;            
output [39:0] result;
output        co;             
reg [39:0] result;
reg        co;
reg [ 5:0] shift_cnt;
reg [39:0] operand;
always@(selo or t or asm or imm)
	case (selo) 
		2'b00: shift_cnt = t;
		2'b01: shift_cnt = {asm, asm, asm, asm, asm};
		2'b10: shift_cnt = {imm, imm, imm, imm, imm};
		2'b11: shift_cnt = {imm, imm, imm, imm, imm};
	endcase
always@(seli or bp_a or a or bp_ar or bp_b or b or bp_br or cb or db)
	case (seli) 
		2'b00 : operand = bp_b ? bp_br : b;
		2'b01 : operand = bp_a ? bp_ar : a;
		2'b10 : operand = db;       
		2'b11 : operand = {cb, db}; 
	endcase
always@(posedge clk)
	if (ena)
		if (l_na) 
			if (shift_cnt[5])
				begin
					result[39:32] <= 8'h0;
					result[31: 0] <= operand[31:0] >> 2;
					co            <= operand[0];
				end
			else if ( ~|shift_cnt[4:0] )
				begin
					result <= operand;
					co     <= 1'b0;
				end
			else
				begin
					result[39:32] <= 8'h0;
					result[31: 0] <= operand[31:0] << 1;
					co            <= operand[0];
				end
		else      
			if (shift_cnt[5])
				begin
					if (sxm)
						result <= operand >> 4;
					else
						result <= operand >> 3;
					co     <= operand[0];
				end
			else
				begin
					result <= operand << 5;
					co     <= operand[0];
				end
endmodule