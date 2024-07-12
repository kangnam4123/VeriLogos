module ultra_slice_logic_ffmux #(
	parameter [1023:0] SEL = "BYP"
) (
	input XORIN, F7F8, D6, D5, CY, BYP,
	output OUT
);
	generate
		case(SEL)
			"XORIN": assign OUT = XORIN;
			"F7F8":  assign OUT = F7F8;
			"D6":    assign OUT = D6;
			"D5":    assign OUT = D5;
			"CY":    assign OUT = CY;
			"BYP":   assign OUT = BYP;
		endcase
	endgenerate
endmodule