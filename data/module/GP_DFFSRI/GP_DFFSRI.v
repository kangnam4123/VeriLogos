module GP_DFFSRI(input D, CLK, nSR, output reg nQ);
	parameter [0:0] INIT = 1'bx;
	parameter [0:0] SRMODE = 1'bx;
	initial nQ = INIT;
	always @(posedge CLK, negedge nSR) begin
		if (!nSR)
			nQ <= ~SRMODE;
		else
			nQ <= ~D;
	end
endmodule