module memtest08(input clk, input [3:0] a, b, c, output reg [3:0] y);
	reg [3:0] mem [0:15] [0:15];
	always @(posedge clk) begin
		y <= mem[a][b];
		mem[a][b] <= c;
	end
endmodule