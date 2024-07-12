module JTAG_TRANS (
                   iTxD_DATA, iTxD_Start, oTxD_Done,
                   TDO, TCK, TCS);
input       [7:0] iTxD_DATA;
input             iTxD_Start;
output reg        oTxD_Done;
input             TCK, TCS;
output reg        TDO;
reg         [2:0] rCont;
always@(posedge TCK or posedge TCS)
begin
  if (TCS)
  begin
    oTxD_Done   <= 1'b0;
    rCont       <= 3'b000;
    TDO         <= 1'b0;
  end
  else
  begin
    if (iTxD_Start)
    begin
      rCont     <= rCont + 3'b001;
      TDO       <= iTxD_DATA[rCont];
    end
    else
    begin
      rCont     <= 3'b000;
      TDO       <= 1'b0;
    end
    if (rCont == 3'b111)
    begin
      oTxD_Done <= 1'b1;
    end
    else
    begin
      oTxD_Done <= 1'b0;
    end
  end
end
endmodule