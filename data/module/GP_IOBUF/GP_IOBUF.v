module GP_IOBUF(input IN, input OE, output OUT, inout IO);
	assign OUT = IO;
	assign IO = OE ? IN : 1'bz;
endmodule