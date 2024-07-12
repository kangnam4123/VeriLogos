module SRn_ff(output Q, Qn, input Sn, Rn);
	nand a1(Q,  Sn, Qn),
	     a2(Qn, Rn, Q);
endmodule