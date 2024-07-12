module ds8dac1_1(clk, DACin, DACout);
output DACout; 
reg DACout; 
input [7:0] DACin; 
input clk;
reg [9:0] DeltaAdder; 
reg [9:0] SigmaAdder; 
reg [9:0] SigmaLatch; 
reg [9:0] DeltaB; 
initial
begin
  DeltaAdder = 10'd0;
  SigmaAdder = 10'd0;
  SigmaLatch = 10'd0;
  DeltaB = 10'd0;
end
always @(SigmaLatch) DeltaB = {SigmaLatch[9], SigmaLatch[9]} << (8);
always @(DACin or DeltaB) DeltaAdder = DACin + DeltaB;
always @(DeltaAdder or SigmaLatch) SigmaAdder = DeltaAdder + SigmaLatch;
always @(posedge clk)
begin
  SigmaLatch <= SigmaAdder;
  DACout <=  SigmaLatch[9];
end
endmodule