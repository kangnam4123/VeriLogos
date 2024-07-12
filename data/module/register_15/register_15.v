module register_15 # (parameter N = 8)
	(input clk,
	 input [N-1:0] in,
    output reg [N-1:0] out,
    input load,
    input clear
    );
	 always @ (posedge clk or posedge clear)
		if (clear)		out <= 0;
		else if (load)	out <= in;
		else			out <= in;
endmodule