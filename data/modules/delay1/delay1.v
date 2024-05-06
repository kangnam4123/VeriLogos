module delay1(clock, in, out);
parameter	N = 1;
input	[N:0]	in;
output	[N:0]	out;
input		clock;
reg	[N:0]	out;
always @(posedge clock)
	out <= #1 in;
endmodule