module pipeline_3_latch_4(clk, dbusWire1, DselectWire2, bbusWire2, lwSwFlag2, dbusWire2, DselectWire3,bbusWire3,lwSwFlag3,branchControlBitWire1,branchControlBitWire2);
  input clk;
  input [31:0] dbusWire1, DselectWire2, bbusWire2;
  input [1:0] lwSwFlag2;
  input [1:0] branchControlBitWire1;
  output [31:0] dbusWire2, DselectWire3, bbusWire3;
  output [1:0] lwSwFlag3;
  output [1:0] branchControlBitWire2;
  reg [31:0] dbusWire2, DselectWire3, bbusWire3;
  reg [1:0] lwSwFlag3;
  reg [1:0] branchControlBitWire2;
  always @(posedge clk) begin
    dbusWire2 = dbusWire1;
    DselectWire3 = DselectWire2;
    bbusWire3 = bbusWire2;
    lwSwFlag3 = lwSwFlag2;
    branchControlBitWire2 = branchControlBitWire1;
  end
endmodule