module ultra_slice_carry_cimux #(
	parameter SEL = "CI"
) (
	input CI, X,
	output OUT
);
	generate
		case(SEL)
			"CI": assign OUT = CI;
			"0":  assign OUT = 1'b0;
			"1":  assign OUT = 1'b1;
			"X":  assign OUT = X;
		endcase
	endgenerate
endmodule