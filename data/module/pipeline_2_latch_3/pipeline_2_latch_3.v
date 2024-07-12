module pipeline_2_latch_3(clk, abusWire1, bbusWire1, DselectWire1, immWire1, SWire1, CinWire1,immBit1,lwSwFlag1,
abusWire2,bbusWire2,immWire2,SWire2,CinWire2,DselectWire2,immBit2,lwSwFlag2,setControlBits,setControlBitsWire1,
branchControlBit,branchControlBitWire1);
  input clk, CinWire1,immBit1;
  input [31:0] abusWire1, bbusWire1, DselectWire1, immWire1;
  input [2:0] SWire1;
  input [1:0] lwSwFlag1;
  input [1:0] setControlBits;
  input [1:0] branchControlBit;
  output CinWire2,immBit2;
  output [31:0] abusWire2, bbusWire2, DselectWire2, immWire2;
  output [2:0] SWire2;
  output [1:0] lwSwFlag2;
  output [1:0] setControlBitsWire1;
  output [1:0] branchControlBitWire1;
  reg CinWire2,immBit2;
  reg [31:0] abusWire2, bbusWire2, DselectWire2, immWire2;
  reg [2:0] SWire2;
  reg [1:0] lwSwFlag2;
  reg [1:0] setControlBitsWire1;
  reg [1:0] branchControlBitWire1;
  always @(posedge clk) begin
    abusWire2 = abusWire1;
    bbusWire2 = bbusWire1;
    DselectWire2 = DselectWire1;
    immWire2 = immWire1;
    SWire2 = SWire1;
    CinWire2 = CinWire1;
    immBit2 = immBit1;
    lwSwFlag2 = lwSwFlag1;
    setControlBitsWire1 = setControlBits;
    branchControlBitWire1 = branchControlBit;
  end
endmodule