module SR_ff(output Q, Qn, input S, R);
	nor n1(Q,  R, Qn),
	    n2(Qn, S, Q);
endmodule