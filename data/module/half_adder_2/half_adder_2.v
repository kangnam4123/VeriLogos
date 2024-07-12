module half_adder_2(x, y, Cout, s);
	input x, y;
	output Cout, s; 
	assign s = x ^ y;
	assign Cout = x & y;
endmodule