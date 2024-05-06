module bilinear (A,B,bilinear_out);
	input [7:0] A,B;
	output [7:0] bilinear_out;
	wire [8:0] sum_AB;
	assign sum_AB = A + B + 1; 
	assign bilinear_out = sum_AB[8:1];
endmodule