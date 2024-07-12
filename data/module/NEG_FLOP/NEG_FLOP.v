module NEG_FLOP (CLK, D, Q);
input CLK;
input D;
output reg Q;
always @(negedge CLK)
begin
	Q <= D;
end
endmodule