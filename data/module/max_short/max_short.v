module max_short(
   input [15:0] x,
	input [15:0] y,
	output [15:0] z
);
assign z = ( y > x) ? y : x;
endmodule