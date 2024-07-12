module MHA (Sum, Cout, A, B, Sin);
   input A;
   input B;
   input Sin;
   output Sum;
   output Cout;
	wire	w1;
	and	a0(w1, A, B);
	xor	x1(Sum, w1, Sin);
	and	a1(Cout, w1, Sin);
endmodule