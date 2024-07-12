module mux2_12(output Q, input X, Y, sel);
	not(sel_l, sel);
	and(d1, X, sel_l);
	and(d2, Y, sel);
	or (Q,d1,d2);
endmodule