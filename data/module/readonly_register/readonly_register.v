module readonly_register(
	reg_clk, reg_addr, reg_data, reg_wr,
	value
);
parameter ADDR = 1;
input	reg_clk;
input	[15:0] reg_addr;
inout	[31:0] reg_data;
input	reg_wr;
input	[31:0] value;
assign reg_data = (reg_addr == ADDR && !reg_wr) ? value : 32'hZZ;
endmodule