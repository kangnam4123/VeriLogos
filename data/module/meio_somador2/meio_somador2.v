module meio_somador2 ( a, b, soma, cout);
    input a, b;
    output soma, cout;
	 assign soma = a ^ b;
    assign cout = a * b;
endmodule