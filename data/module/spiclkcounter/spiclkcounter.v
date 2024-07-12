module spiclkcounter(
  output [3:0] clkcount,
  input clk,
  input en);
  reg [3:0] countreg = 0;
  assign clkcount = countreg;
  always @(posedge clk, negedge en) begin
    if(en)
    	countreg <= countreg + 1;
    else
    	countreg <= 4'h0;
  end
endmodule