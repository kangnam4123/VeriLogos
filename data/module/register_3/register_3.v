module register_3(
	reg_clk, reg_addr, reg_data, reg_wr,
	clk, value
);
parameter ADDR = 1;
input	reg_clk;
input	[15:0] reg_addr;
inout	[31:0] reg_data;
input	reg_wr;
input	clk;
output	[31:0] value;
reg	[31:0] value;
initial value = 32'h0;
always @(posedge reg_clk)
if (reg_addr == ADDR && reg_wr)
	value <= reg_data;
assign reg_data = (reg_addr == ADDR && !reg_wr) ? value : 32'hZZ;
endmodule