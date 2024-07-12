module FFD_NoCE
	# (parameter W = 16)
	(
		input wire clk, 
		input wire rst, 
		input wire [W-1:0] D, 
		output reg [W-1:0] Q 
    );
	always @(posedge clk, posedge rst)
		if(rst)
			Q <= 0;
		else
			Q <= D;
endmodule