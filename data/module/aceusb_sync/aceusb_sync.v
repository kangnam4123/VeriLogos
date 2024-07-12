module aceusb_sync(
	input clk0,
	input flagi,
	input clk1,
	output flago
);
reg toggle;
initial toggle = 1'b0;
always @(posedge clk0)
	if(flagi) toggle <= ~toggle;
reg [2:0] sync;
initial sync = 3'b000;
always @(posedge clk1)
	sync <= {sync[1:0], toggle};
assign flago = sync[2] ^ sync[1];
endmodule