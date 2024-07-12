module rotate_left #(
	parameter M = 4,
	parameter S = 0
) (
	input [M-1:0] in,
	output [M-1:0] out
);
	wire [M*2-1:0] in2 = {in, in};
	assign out = in2[M-(S%M)+:M];
endmodule