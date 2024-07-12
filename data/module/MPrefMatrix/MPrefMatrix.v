module MPrefMatrix
#(
  parameter Kw =8,
  parameter Km =8,
  parameter M  =8,
  parameter W  =8
)
(
  mPref,
  raddr,
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
  input   [Km*logW-1:0] mPref;
  input   [logKm-1:0]   raddr;
  output  [logW-1:0]    rdata;
  wire [logW-1:0] mPrefMatrix [Km-1:0]; 
  genvar j;
  generate
    for (j=0;j<Km;j=j+1) begin : mPref_asgn2
      assign mPrefMatrix [j] = mPref [logW*(j+1)-1:logW*j];
    end
  endgenerate
  assign rdata = mPrefMatrix[raddr];
endmodule