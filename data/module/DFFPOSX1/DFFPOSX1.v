module DFFPOSX1(CLK, D, Q);
input CLK, D;
output reg Q;
always @(posedge CLK)
	Q <= D;
endmodule