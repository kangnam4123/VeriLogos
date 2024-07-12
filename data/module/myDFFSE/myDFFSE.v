module myDFFSE (output reg Q, input D, CLK, CE, SET);
	parameter [0:0] INIT = 1'b1;
	initial Q = INIT;
	always @(posedge CLK) begin
		if (SET)
			Q <= 1'b1;
		else if (CE)
			Q <= D;
end
endmodule