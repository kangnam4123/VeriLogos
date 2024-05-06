module bw_r_idct_array(we, clk, rd_data, wr_data, addr);
input we;
input clk;
input [32:0] wr_data;
input [6:0] addr;
output [32:0] rd_data;
reg [32:0] rd_data;
reg	[32:0]		array[127:0]  ;
	always @(negedge clk) begin
	  if (we) array[addr] <= wr_data;
	  else rd_data <= array[addr];
	end
endmodule