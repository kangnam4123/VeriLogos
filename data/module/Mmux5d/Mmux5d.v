module Mmux5d (out, in0, s0, in1, s1, in2, s2, in3, s3, in4, s4);
parameter bits = 32;	
output [bits-1:0] out;
input [bits-1:0] in0, in1, in2, in3, in4;
input s0, s1, s2, s3, s4;
	reg [bits-1:0] out;
	always @ (s0 or s1 or s2 or s3 or s4
				or in0 or in1 or in2 or in3 or in4) begin
		case ({s4, s3, s2, s1, s0})	
			5'b00001:	out = in0;
			5'b00010:	out = in1;
			5'b00100:	out = in2;
			5'b01000:	out = in3;
			5'b10000:	out = in4;
			default:	out = 65'hx;
		endcase
	end
endmodule