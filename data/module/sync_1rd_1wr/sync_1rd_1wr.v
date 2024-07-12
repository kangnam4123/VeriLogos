module sync_1rd_1wr (
  input clk,
  input [7:0] a, 
  input we, 
  input [15:0] d,
  output reg [15:0] q
);
  reg [15:0] mem[0:255];
  always @(posedge clk) if (we) mem[a] <= d;
  always @(posedge clk) q <= mem[a];
endmodule