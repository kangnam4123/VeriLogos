module myDFFE (output reg Q, input D, CLK, CE);
	parameter [0:0] INIT = 1'b0;
	initial Q = INIT;
	always @(posedge CLK) begin
		if (CE)
			Q <= D;
	end
endmodule