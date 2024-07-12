module init_1(input wire clk, output wire ini);
wire din;
reg dout = 0;
always @(posedge(clk))
  dout <= din;
assign din = 1;
assign ini = dout;
endmodule