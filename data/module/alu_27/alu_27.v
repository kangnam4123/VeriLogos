module alu_27 #(parameter B = 32)
	(
	input wire signed [B-1:0] op1,
	input wire signed [B-1:0] op2,
	input wire [3:0] alu_control,
	output wire [B-1:0] result,
	output wire zero
	);
	assign result = 	(alu_control == 4'b0000) ? op1 + op2 : 
							(alu_control == 4'b0001) ? op1 - op2 : 
							(alu_control == 4'b0010) ? op1 & op2 : 
							(alu_control == 4'b0011) ? op1 | op2 : 
							(alu_control == 4'b0100) ? op1 ^ op2 : 
							(alu_control == 4'b0101) ? ~(op1 | op2) : 
							(alu_control == 4'b0110) ? op1 < op2 : 
							(alu_control == 4'b0111) ? op1 << op2[10:6] : 
							(alu_control == 4'b1000) ? op1 >> op2[10:6] : 
							(alu_control == 4'b1001) ? {$signed(op1) >>> op2[10:6]} : 
							(alu_control == 4'b1010) ? op2 << op1 : 
							(alu_control == 4'b1011) ? op2 >> op1 : 
							(alu_control == 4'b1100) ? {$signed(op2) >>> op1} : 
							(alu_control == 4'b1101) ? {op2[15:0],16'b00000000_00000000} : 
							32'b11111111_11111111_11111111_11111111;
	assign zero = (result == 0) ? 1'b1 : 1'b0;
endmodule