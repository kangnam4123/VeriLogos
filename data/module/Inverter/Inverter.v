module Inverter (
	input positive,
	output negative
	);
	assign negative = ~positive;
endmodule