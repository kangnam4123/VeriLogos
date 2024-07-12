module select_leaves(input R, C, D, output reg Q);
	always @(posedge C)
		if (!R)
			Q <= R;
		else
			Q <= Q ? Q : D ? D : Q;
endmodule