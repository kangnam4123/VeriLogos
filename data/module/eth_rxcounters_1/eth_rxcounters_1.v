module eth_rxcounters_1 
  (
   MRxClk, Reset, MRxDV, StateIdle, StateSFD, StateData, StateDrop, StatePreamble, 
   MRxDEqD, DlyCrcEn, DlyCrcCnt, Transmitting, MaxFL, r_IFG, HugEn, IFGCounterEq24, 
   ByteCntEq0, ByteCntEq1, ByteCntEq2,ByteCntEq3,ByteCntEq4,ByteCntEq5, ByteCntEq6,
   ByteCntEq7, ByteCntGreat2, ByteCntSmall7, ByteCntMaxFrame, ByteCntOut
   );
input         MRxClk;
input         Reset;
input         MRxDV;
input         StateSFD;
input [1:0]   StateData;
input         MRxDEqD;
input         StateIdle;
input         StateDrop;
input         DlyCrcEn;
input         StatePreamble;
input         Transmitting;
input         HugEn;
input [15:0]  MaxFL;
input         r_IFG;
output        IFGCounterEq24;           
output [3:0]  DlyCrcCnt;                
output        ByteCntEq0;               
output        ByteCntEq1;               
output        ByteCntEq2;               
output        ByteCntEq3;               
output        ByteCntEq4;               
output        ByteCntEq5;               
output        ByteCntEq6;               
output        ByteCntEq7;               
output        ByteCntGreat2;            
output        ByteCntSmall7;            
output        ByteCntMaxFrame;          
output [15:0] ByteCntOut;               
wire          ResetByteCounter;
wire          IncrementByteCounter;
wire          ResetIFGCounter;
wire          IncrementIFGCounter;
wire          ByteCntMax;
reg   [15:0]  ByteCnt;
reg   [3:0]   DlyCrcCnt;
reg   [4:0]   IFGCounter;
wire  [15:0]  ByteCntDelayed;
assign ResetByteCounter = MRxDV & (StateSFD & MRxDEqD | StateData[0] & ByteCntMaxFrame);
assign IncrementByteCounter = ~ResetByteCounter & MRxDV & 
                              (StatePreamble | StateSFD | StateIdle & ~Transmitting |
                               StateData[1] & ~ByteCntMax & ~(DlyCrcEn & |DlyCrcCnt)
                              );
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    ByteCnt[15:0] <=  16'd0;
  else
    begin
      if(ResetByteCounter)
        ByteCnt[15:0] <=  16'd0;
      else
      if(IncrementByteCounter)
        ByteCnt[15:0] <=  ByteCnt[15:0] + 16'd1;
     end
end
assign ByteCntDelayed = ByteCnt + 16'd4;
assign ByteCntOut = DlyCrcEn ? ByteCntDelayed : ByteCnt;
assign ByteCntEq0       = ByteCnt == 16'd0;
assign ByteCntEq1       = ByteCnt == 16'd1;
assign ByteCntEq2       = ByteCnt == 16'd2; 
assign ByteCntEq3       = ByteCnt == 16'd3; 
assign ByteCntEq4       = ByteCnt == 16'd4; 
assign ByteCntEq5       = ByteCnt == 16'd5; 
assign ByteCntEq6       = ByteCnt == 16'd6;
assign ByteCntEq7       = ByteCnt == 16'd7;
assign ByteCntGreat2    = ByteCnt >  16'd2;
assign ByteCntSmall7    = ByteCnt <  16'd7;
assign ByteCntMax       = ByteCnt == 16'hffff;
assign ByteCntMaxFrame  = ByteCnt == MaxFL[15:0] & ~HugEn;
assign ResetIFGCounter = StateSFD  &  MRxDV & MRxDEqD | StateDrop;
assign IncrementIFGCounter = ~ResetIFGCounter & (StateDrop | StateIdle | StatePreamble | StateSFD) & ~IFGCounterEq24;
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    IFGCounter[4:0] <=  5'h0;
  else
    begin
      if(ResetIFGCounter)
        IFGCounter[4:0] <=  5'h0;
      else
      if(IncrementIFGCounter)
        IFGCounter[4:0] <=  IFGCounter[4:0] + 5'd1; 
    end
end
assign IFGCounterEq24 = (IFGCounter[4:0] == 5'h18) | r_IFG; 
always @ (posedge MRxClk or posedge Reset)
begin
  if(Reset)
    DlyCrcCnt[3:0] <=  4'h0;
  else
    begin
      if(DlyCrcCnt[3:0] == 4'h9)
        DlyCrcCnt[3:0] <=  4'h0;
      else
      if(DlyCrcEn & StateSFD)
        DlyCrcCnt[3:0] <=  4'h1;
      else
      if(DlyCrcEn & (|DlyCrcCnt[3:0]))
        DlyCrcCnt[3:0] <=  DlyCrcCnt[3:0] + 4'd1;
    end
end
endmodule