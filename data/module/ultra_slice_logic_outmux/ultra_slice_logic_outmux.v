module ultra_slice_logic_outmux #(
	parameter SEL = "D5"
) (
	input XORIN, F7F8, D6, D5, CY,
	output OUT
);
	generate
		case(SEL)
			"XORIN": assign OUT = XORIN;
			"F7F8":  assign OUT = F7F8;
			"D6":    assign OUT = D6;
			"D5":    assign OUT = D5;
			"CY":    assign OUT = CY;
		endcase
	endgenerate
endmodule