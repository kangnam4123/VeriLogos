module GP_OBUFT_1(input IN, input OE, output OUT);
	assign OUT = OE ? IN : 1'bz;
endmodule