module WIsMatch
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
  rdata
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
  input wdata;
  input wen;
  output rdata;
  reg wIsMatch[W-1:0]; 
  integer k;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (k=0;k<W;k=k+1) begin :always_line
        wIsMatch[k] <= 1'b0;
      end
    end
    else if (wen) begin
      wIsMatch[addr] <= wdata;
    end
  end
  assign rdata = wIsMatch[addr];
endmodule