module GP_DLATCHS_1(input D, input nCLK, input nSET, output reg Q);
	parameter [0:0] INIT = 1'bx;
	initial Q = INIT;
	always @(*) begin
		if(!nSET)
			Q <= 1'b1;
		else if(!nCLK)
			Q <= D;
	end
endmodule