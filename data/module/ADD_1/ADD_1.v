module ADD_1(
	input a,b,c,
	output g,p,s
	);
	assign s = a ^ b ^ c;
	assign g = a & b;
	assign p = a | b;
endmodule