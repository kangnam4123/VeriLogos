module mem_unit #(parameter word_sz = 8, mem_sz = 256)
	(	output [word_sz-1:0] data_out,
		input [word_sz-1:0] data_in, address,
		input clk, write);
	reg [word_sz-1:0] mem[mem_sz-1:0];
	assign data_out = mem[address];
	always @(posedge clk)
		if (write)
			mem[address] <= data_in;
endmodule