module alu_p #(parameter WIDTH=8)
	(output reg [WIDTH:0] out,
		input [WIDTH-1:0] a, b, input c_in, input [2:0]op);
	parameter [2:0]
		OP_ADD  = 0,
		OP_SUB  = 1,
		OP_SUBB = 2,
		OP_OR   = 3,
		OP_AND  = 4,
		OP_NOT  = 5,
		OP_XOR  = 6,
		OP_XNOR = 7;
	always @(a, b, op, c_in)
		case (op)
			OP_ADD: out <= a + b + c_in;
			OP_SUB: out <= a + (~b) + c_in;
			OP_SUBB:out <= b + (~a) + (~c_in);
			OP_OR:  out <= {1'b0, a | b};
			OP_AND: out <= {1'b0, a & b};
			OP_NOT: out <= {1'b0, (~a) & b};
			OP_XOR: out <= {1'b0, a ^ b};
			OP_XNOR:out <= {1'b0, a ~^ b};
		endcase
endmodule