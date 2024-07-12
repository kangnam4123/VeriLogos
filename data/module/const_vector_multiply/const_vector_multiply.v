module const_vector_multiply #(
	parameter C = 4,
	parameter [C-1:0] VECTOR = 0,
	parameter R = C
) (
	input [C*R-1:0] matrix,
	output [R-1:0] out
);
	parameter LOG2C = $clog2(C+1);
	function integer degree;
		input dummy;
		integer i;
		integer c;
	begin
		c = 0;
		for (i = 0; i < C; i = i + 1)
			c = c + VECTOR[i];
		degree = c;
	end
	endfunction
	function [LOG2C*C-1:0] idx;
		input [LOG2C-1:0] max;
		integer i;
		integer c;
	begin
		c = 0;
		for (i = 0; i < C; i = i + 1) begin
			idx[LOG2C*i+:LOG2C] = c;
			if (VECTOR[i] && c < max)
				c = c + 1;
		end
	end
	endfunction
	localparam DEGREE = degree(0);
	localparam [LOG2C*C-1:0] IDXS = idx(DEGREE - 1);
	if (DEGREE) begin
		genvar i, j;
		for (i = 0; i < R; i = i + 1) begin : ROWS
			wire [DEGREE-1:0] terms;
			for (j = 0; j < C; j = j + 1) begin : TERMS
				localparam IDX = IDXS[LOG2C*j+:LOG2C];
				if (VECTOR[j])
					assign terms[IDX] = matrix[i*C+j];
			end
			assign out[i] = ^terms;
		end
	end else
		assign out = 0;
endmodule