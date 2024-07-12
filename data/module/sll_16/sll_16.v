module sll_16(a, lsb, out);
	input [31:0] a;
	input lsb;
	output[31:0] out;
	wire [31:0] out;
	genvar i;
	generate
		for(i=16; i<32; i=i+1) begin: shift_sixteen_loop
			assign out[i] = a[i-16];
		end
	endgenerate
	genvar j;
	generate
		for(j=0; j<16; j=j+1) begin: shift_sixteen_sub_loop
			assign out[j] = lsb;
		end
	endgenerate
endmodule