module const_matrix_multiply #(
	parameter C = 4,
	parameter R = C,
	parameter [C*R-1:0] MATRIX = 0
) (
	input [R-1:0] vector,
	output [C-1:0] out
);
	parameter LOG2C = $clog2(C+1);
	function integer degree;
		input [LOG2C-1:0] row;
		integer i;
		integer c;
	begin
		c = 0;
		for (i = 0; i < C; i = i + 1)
			c = c + MATRIX[row*C+i];
		degree = c;
	end
	endfunction
	function [LOG2C*C-1:0] idx;
		input [LOG2C-1:0] row;
		input [LOG2C-1:0] max;
		integer i;
		integer c;
	begin
		c = 0;
		for (i = 0; i < C; i = i + 1) begin
			idx[LOG2C*i+:LOG2C] = c;
			if (MATRIX[row*C+i] && c < max)
				c = c + 1;
		end
	end
	endfunction
	genvar i, j;
	for (i = 0; i < R; i = i + 1) begin : OUT
		localparam DEGREE = degree(i);
		if (DEGREE > 0) begin
			localparam [LOG2C*C-1:0] IDXS = idx(i, DEGREE - 1);
			wire [DEGREE-1:0] terms;
			for (j = 0; j < C; j = j + 1) begin : TERMS
				localparam IDX = IDXS[LOG2C*j+:LOG2C];
				if (MATRIX[i*C+j])
					assign terms[IDX] = vector[j];
			end
			assign out[i] = ^terms;
		end else
			assign out[i] = 0;
	end
endmodule