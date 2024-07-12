module POS_FLOP (CLK, D, Q);
input CLK;
input D;
output reg Q;
always @(posedge CLK)
begin
	Q <= D;
end
endmodule