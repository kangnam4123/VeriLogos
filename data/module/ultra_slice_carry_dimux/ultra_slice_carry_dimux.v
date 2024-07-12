module ultra_slice_carry_dimux #(
	parameter SEL = "DI"
) (
	input DI, X,
	output OUT
);
	generate
		case(SEL)
			"DI": assign OUT = DI;
			"X":  assign OUT = X;
		endcase
	endgenerate
endmodule