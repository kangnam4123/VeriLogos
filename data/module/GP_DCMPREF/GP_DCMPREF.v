module GP_DCMPREF(output reg[7:0]OUT);
	parameter[7:0] REF_VAL = 8'h00;
	initial OUT = REF_VAL;
endmodule