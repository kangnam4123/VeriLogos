module pipeline_4_latch_2(clk, dbusWire2, DselectWire3, bbusWire3, lwSwFlag3, dbusWire3, DselectWire4,bbusWire4,lwSwFlag4,branchControlBitWire2,
branchControlBitWire3,NOPWire2,NOPWire3);
  input clk;
  input [63:0] dbusWire2, bbusWire3;
  input [31:0] DselectWire3;
  input [1:0] lwSwFlag3;
  input [2:0] branchControlBitWire2;
  input NOPWire2;
  output [63:0] dbusWire3, bbusWire4;
  output [31:0] DselectWire4;
  output [1:0] lwSwFlag4;
  output [2:0] branchControlBitWire3;
  output NOPWire3;
  reg [63:0] dbusWire3, bbusWire4;
  reg [31:0] DselectWire4;
  reg [1:0] lwSwFlag4;
  reg [2:0] branchControlBitWire3;
  reg NOPWire3;
  always @(posedge clk) begin
    dbusWire3 = dbusWire2;
    DselectWire4 = DselectWire3;
    bbusWire4 = bbusWire3;
    lwSwFlag4 = lwSwFlag3;
    branchControlBitWire3 = branchControlBitWire2;
    NOPWire3 = NOPWire2;
  end
endmodule