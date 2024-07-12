module sll_2(a, lsb, out);
	input [31:0] a;
	input lsb;
	output[31:0] out;
	wire [31:0] out;
	genvar i;
	generate
		for(i=2; i<32; i=i+1) begin: shift_two_loop
			assign out[i] = a[i-2];
		end
	endgenerate
	assign out[0] = lsb;
	assign out[1] = lsb;
endmodule