module memtest11(clk, wen, waddr, raddr, wdata, rdata);
	input clk, wen;
	input [1:0] waddr, raddr;
	input [7:0] wdata;
	output [7:0] rdata;
	reg [7:0] mem [3:0];
	assign rdata = mem[raddr];
	always @(posedge clk) begin
		if (wen)
			mem[waddr] <= wdata;
		else
			mem[waddr] <= mem[waddr];
	end
endmodule