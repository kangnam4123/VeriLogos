module or2(output Z, input A, B);
	wire i;
	not(Z, i);
	nor(i, A, B);
endmodule