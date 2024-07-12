module myDFFNCE (output reg Q, input D, CLK, CE, CLEAR);
	parameter [0:0] INIT = 1'b0;
	initial Q = INIT;
	always @(negedge CLK or posedge CLEAR) begin
		if(CLEAR)
			Q <= 1'b0;
		else if (CE)
			Q <= D;
	end
endmodule