module Alu(input[31:0] op1,
		input[31:0] op2,
		input[3:0] f,
		output reg[31:0] result,
		output zero);
	always @(op1, op2, f)
		case (f)
			0: result = op1 + op2;
            1: result = op1 - op2;
            2: result = op1 & op2;
            3: result = op1 | op2;
            4: result = op1 ~| op2;
            5: result = op1 ^ op2;
            6: result = op1 << op2;
            7: result = op1 >> op2;
            8: result = op1 >>> op2;
            9: result = ($signed(op1) < $signed(op2)) ? 1 : 0; 
            10: result = (op1 < op2) ? 1 : 0;   
        endcase 
	assign zero = result == 0;
endmodule