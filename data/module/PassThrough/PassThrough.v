module PassThrough(a, b);
	input wire [3:0] a;
	output wire [3:0] b;
	assign b = a;
endmodule