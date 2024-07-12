module PC_3
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
  input [logM-1:0] addr;
  input [logKm:0] wdata;
  input wen;
  output [logKm:0] rdata;
  reg [logKm:0] pc [M-1:0]; 
  integer k;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      for (k=0;k<M;k=k+1) begin :always_line
        pc[k] <= Km;
      end
    end
    else if (wen) begin
      pc[addr] <= wdata;
    end
  end
  assign rdata = pc[addr];
endmodule