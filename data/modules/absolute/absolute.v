module absolute (a,b,out);
	input [7:0] a,b;
	output [7:0] out;
	assign out = (a > b)? (a - b):(b - a);
endmodule