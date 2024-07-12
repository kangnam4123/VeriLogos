module myDFFR (output reg Q, input D, CLK, RESET);
	parameter [0:0] INIT = 1'b0;
	initial Q = INIT;
	always @(posedge CLK) begin
		if (RESET)
			Q <= 1'b0;
		else
			Q <= D;
	end
endmodule