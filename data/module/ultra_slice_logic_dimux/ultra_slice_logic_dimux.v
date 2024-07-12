module ultra_slice_logic_dimux #(
	parameter [1023:0] SEL = "DI"
) (
	input DI, SIN,
	output OUT
);
	generate
		case(SEL)
			"DI": assign OUT = DI;
			"SIN":  assign OUT = SIN;
		endcase
	endgenerate
endmodule