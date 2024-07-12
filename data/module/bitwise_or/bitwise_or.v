module bitwise_or(a, b, out);
	input [31:0] a, b;
	output [31:0] out;
	wire [31:0] out;
	genvar i;
	generate
		for(i=0; i<32; i=i+1) begin: or_loop
			or(out[i], a[i], b[i]);
		end
	endgenerate
endmodule