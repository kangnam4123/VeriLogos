module ram_32x32_dp
	(
	input			wrclock,
	input			wren,
	input	[4:0]		wraddress,
	input	[31:0]		data,
	input			rdclock,
	input	[4:0]		rdaddress,
	output	reg	[31:0]	q 
	);
reg	[31:0]	mem_a [0:31];
always @(posedge wrclock) if(wren) mem_a[wraddress] <= data;
always @(posedge rdclock) q <= mem_a[rdaddress];
endmodule