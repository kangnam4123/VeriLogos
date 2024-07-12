module FACADE_IO #(
	parameter DIR = "INPUT"
) (
	inout PAD,
	input I, T,
	output O
);
	generate
		if (DIR == "INPUT") begin
			assign O = PAD;
		end else if (DIR == "OUTPUT") begin
			assign PAD = T ? 1'bz : I;
		end else if (DIR == "BIDIR") begin
			assign PAD = T ? 1'bz : I;
			assign O = PAD;
		end else begin
			ERROR_UNKNOWN_IO_MODE error();
		end
	endgenerate
endmodule