module plane_a_precomputation (pix_in1,pix_in2,a_out);
	input [7:0] pix_in1,pix_in2;
	output [13:0] a_out;
	wire [8:0] sum;
	assign sum = pix_in1 + pix_in2;
	assign a_out = {1'b0,sum,4'b0};
endmodule