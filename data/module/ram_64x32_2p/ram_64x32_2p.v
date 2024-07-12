module ram_64x32_2p
	(
	input			clock,
	input			wren,
	input	[4:0]		wraddress,
	input	[4:0]		rdaddress,
	input	[63:0]		data,
	output	reg	[63:0]	q 
	);
reg	[63:0]	mem_a [0:31];
always @(posedge clock) if(wren) mem_a[wraddress] <= data;
always @(posedge clock) q <= mem_a[rdaddress];
endmodule