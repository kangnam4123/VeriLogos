module sync_1rd_1wr_t (
  input clk,
  input [7:0] a, 
  input we, 
  input [15:0] d,
  output [15:0] q
);
  reg [15:0] mem[0:255];
  reg [7:0] ra;
  always @(posedge clk) if (we) mem[a] <= d;
  always @(posedge clk) ra <= a;
  assign q = mem[ra];
endmodule