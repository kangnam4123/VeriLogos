module and2(output Z, input A, B);
	nand(nz, A, B);
	not(Z, nz);
endmodule