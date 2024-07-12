module pipeline_2_latch_1(clk, abusWire1, bbusWire1, DselectWire1, ALUImmWire1, SWire1, CinWire1,immBit1,lwSwFlag1,
abusWire2,bbusWire2,ALUImmWire2,SWire2,CinWire2,DselectWire2,immBit2,lwSwFlag2,setControlBits,setControlBitsWire1,
branchControlBit,branchControlBitWire1,NZVCSetBit,NZVCSetBitWire1,shiftBit1,shiftBit2,shamt,shamtWire1,DTAddrWire1,
DTAddrWire2,MOVImmWire1,MOVImmWire2,movBit1,movBit2,moveImmShftAmt,moveImmShftAmtWire1,NOP,NOPWire1);
  input clk, CinWire1,immBit1,NOP;
  input [63:0] abusWire1, bbusWire1, ALUImmWire1,DTAddrWire1,MOVImmWire1;
  input [31:0] DselectWire1;
  input [2:0] SWire1;
  input [1:0] lwSwFlag1;
  input [1:0] setControlBits;
  input [2:0] branchControlBit;
  input NZVCSetBit;
  input [1:0] shiftBit1;
  input [5:0] shamt,moveImmShftAmt;
  input movBit1;
  output CinWire2,immBit2,NOPWire1;
  output [63:0] abusWire2, bbusWire2, ALUImmWire2,DTAddrWire2,MOVImmWire2;
  output [31:0] DselectWire2;
  output [2:0] SWire2;
  output [1:0] lwSwFlag2;
  output [1:0] setControlBitsWire1;
  output [2:0] branchControlBitWire1;
  output NZVCSetBitWire1;
  output [1:0] shiftBit2;
  output [5:0] shamtWire1,moveImmShftAmtWire1;
  output movBit2;
  reg CinWire2,immBit2,NOPWire1;
  reg [63:0] abusWire2, bbusWire2, ALUImmWire2,DTAddrWire2,MOVImmWire2;
  reg [31:0] DselectWire2;
  reg [2:0] SWire2;
  reg [1:0] lwSwFlag2;
  reg [1:0] setControlBitsWire1;
  reg [2:0] branchControlBitWire1;
  reg NZVCSetBitWire1;
  reg [1:0] shiftBit2;
  reg [5:0] shamtWire1,moveImmShftAmtWire1;
  reg movBit2;
  always @(posedge clk) begin
    abusWire2 = abusWire1;
    bbusWire2 = bbusWire1;
    DselectWire2 = DselectWire1;
    ALUImmWire2 = ALUImmWire1;
    SWire2 = SWire1;
    CinWire2 = CinWire1;
    immBit2 = immBit1;
    lwSwFlag2 = lwSwFlag1;
    setControlBitsWire1 = setControlBits;
    branchControlBitWire1 = branchControlBit;
    NZVCSetBitWire1 = NZVCSetBit;
    shiftBit2 = shiftBit1;
    shamtWire1 = shamt;
    DTAddrWire2 = DTAddrWire1;
    MOVImmWire2 = MOVImmWire1;
    movBit2 = movBit1;
    moveImmShftAmtWire1 = moveImmShftAmt;
    NOPWire1 = NOP;
  end
endmodule