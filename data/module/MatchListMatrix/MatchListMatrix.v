module MatchListMatrix
#(
  parameter Kw =8,
  parameter Km =8,
  parameter M  =8,
  parameter W  =8
)
(
  clk,
  rst,
  addr,
  wdata,
  wen,
  rdata,
  matchList
);
  function integer log2;
    input [31:0] value;
    reg [31:0] temp;
  begin
    temp = value - 1;
    for (log2=0; temp>0; log2=log2+1)
      temp = temp>>1;
  end
  endfunction
  localparam logM = log2(M);
  localparam logW = log2(W);
  localparam logKm = log2(Km);
  localparam logKw = log2(Kw);
  input clk,rst;
  input [logW-1:0] addr;
  input [logM:0] wdata;
  input wen;
  output [logM:0] rdata;
  output [W*logM-1:0] matchList;
  reg [logM-1:0] matchListMatrix [W-1:0]; 
  integer k;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (k=0;k<M;k=k+1) begin :always_line
        matchListMatrix[k] <= Km;
      end
    end
    else if (wen) begin
      matchListMatrix[addr] <= wdata;
    end
  end
  assign rdata = matchListMatrix[addr];
  genvar i;
  generate
    for (i=0;i<W;i=i+1)begin : matchList_asgn1
      assign matchList [logM*(i+1)-1:logM*i] = matchListMatrix [i] ;
    end
  endgenerate
endmodule