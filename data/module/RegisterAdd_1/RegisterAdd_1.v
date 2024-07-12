module RegisterAdd_1
	# (parameter W = 16)
	(
		input wire clk, 
		input wire rst, 
		input wire load, 
		input wire [W-1:0] D, 
		output reg [W-1:0] Q 
    );
	always @(posedge clk, posedge rst)
		if(rst)
			Q <= 0;
		else if(load)
			Q <= D;
		else
			Q <= Q;
endmodule