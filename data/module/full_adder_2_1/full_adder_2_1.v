module full_adder_2_1(x, y, Cin, Cout, s);
	input x, y, Cin;
	output Cout, s;
	assign Cout = (x & y) | (x & Cin) | (y & Cin);
	assign s = (~x & ~y & Cin) | (~x & y & ~Cin) |
				  (x & y & Cin) | (x & ~y & ~Cin);
endmodule