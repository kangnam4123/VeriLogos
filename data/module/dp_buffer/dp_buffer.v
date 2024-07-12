module dp_buffer(dout, in);
parameter SIZE = 1;
output 	[SIZE-1:0] 	dout;
input	[SIZE-1:0]	in;
assign dout = in;
endmodule