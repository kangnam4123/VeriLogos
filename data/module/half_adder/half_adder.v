module half_adder(output S, C, input A, B);
	xor sum(S,A,B);
	and carry(C,A,B);
endmodule