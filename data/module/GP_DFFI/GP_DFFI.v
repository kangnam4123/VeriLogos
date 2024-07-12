module GP_DFFI(input D, CLK, output reg nQ);
	parameter [0:0] INIT = 1'bx;
	initial nQ = INIT;
	always @(posedge CLK) begin
		nQ <= ~D;
	end
endmodule