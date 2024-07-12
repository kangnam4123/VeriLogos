module rol2(o, i);
output 	[1:28] o;
input	[1:28] i;
assign o={i[3:28],i[1:2]};
endmodule