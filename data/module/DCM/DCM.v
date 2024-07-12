module DCM(CLKIN,PSCLK,PSEN,PSINCDEC,RST,CLK2X,CLK0,CLKFB);
input CLKIN, PSCLK, PSEN, PSINCDEC, RST, CLKFB;
output CLK2X, CLK0;
assign #1 CLK0 = CLKIN;
reg CLK2X;
initial CLK2X=0;
always @(posedge CLK0)
begin
  CLK2X = 1'b1;
  #5;
  CLK2X = 1'b0;
  #5;
  CLK2X = 1'b1;
  #5;
  CLK2X = 1'b0;
end
endmodule