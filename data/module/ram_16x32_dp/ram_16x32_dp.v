module ram_16x32_dp
	(
	input	[15:0]		data,
	input			wren,
	input	[4:0]		wraddress,
	input	[4:0]		rdaddress,
	input			wrclock,
	input			rdclock,
	output	reg	[15:0]	q 
	);
reg	[15:0]	mem_a [0:31];
always @(posedge wrclock) if(wren) mem_a[wraddress] <= data;
always @(posedge rdclock) q <= mem_a[rdaddress];
endmodule