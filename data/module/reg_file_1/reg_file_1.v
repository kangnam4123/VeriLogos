module reg_file_1 #(parameter word_sz = 8, addr_sz = 5)
	(output [word_sz-1:0] do_1, do_2, input [word_sz-1:0]di,
		input [addr_sz-1:0] raddr_1, raddr_2, waddr,
		input wr_enable, clk);
	parameter reg_ct = 2**addr_sz;
	reg [word_sz-1:0] file [reg_ct-1:0];
	assign do_1 = file[raddr_1];
	assign do_2 = file[raddr_2];
	always @(posedge clk)
		if (wr_enable)
			file[waddr] <= di;
endmodule