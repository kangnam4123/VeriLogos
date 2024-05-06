module delay2(clock, in, out);
parameter	N = 1;
input	[N:0]	in;
output	[N:0]	out;
input		clock;
reg	[N:0]	out, r1;
always @(posedge clock)
	r1 <= #1 in;
always @(posedge clock)
	out <= #1 r1;
endmodule