module matrix_vector_multiply #(
	parameter C = 4,
	parameter R = C
) (
	input [C*R-1:0] matrix,
	input [C-1:0] vector,
	output [R-1:0] out
);
	genvar i;
	for (i = 0; i < R; i = i + 1) begin : mult
		assign out[i] = ^(matrix[i*C+:C] & vector);
	end
endmodule