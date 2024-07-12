module Mux( 
		input  D0, D1, s,
		output Y
	);
	assign Y = s ? D1:D0;
endmodule