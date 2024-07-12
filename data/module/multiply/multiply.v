module multiply (y, a, b);
	input [4:0] a, b;
	output [4:0] y;
	reg [9:0] tempy;
	wire [4:0] y;
	assign y = tempy[4:0];
	always @(a or b)
	begin
		tempy = a * b;
	end
endmodule