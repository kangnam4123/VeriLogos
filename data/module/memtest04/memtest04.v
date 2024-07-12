module memtest04(clk, wr_addr, wr_data, wr_enable, rd_addr, rd_data);
input clk, wr_enable;
input [3:0] wr_addr, wr_data, rd_addr;
output [3:0] rd_data;
reg rd_addr_buf;
reg [3:0] memory [0:15];
always @(posedge clk) begin
	if (wr_enable)
		memory[wr_addr] <= wr_data;
	rd_addr_buf <= rd_addr;
end
assign rd_data = memory[rd_addr_buf];
endmodule