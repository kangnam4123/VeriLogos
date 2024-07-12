module WPref_rev_Matrix
#(
  parameter Kw =8,
  parameter Km =8,
  parameter M  =8,
  parameter W  =8
)
(
  wPref_rev,
  raddr1,
  rdata1,
  raddr2,
  rdata2
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
  input [M*logKw-1:0] wPref_rev;
  input   [logM-1:0]   raddr1;
  output  [logKw-1:0]  rdata1;
  input   [logM-1:0]   raddr2;
  output  [logKw-1:0]  rdata2;
  wire [logKw-1:0] wPref_rev_Matrix [M-1:0]; 
  genvar j;
  generate
    for (j=0;j<Kw;j=j+1) begin : wPref_rev_asgn2
      assign wPref_rev_Matrix [j] = wPref_rev [logM*(j+1)-1:logM*j];
    end
  endgenerate
  assign rdata1 = wPref_rev_Matrix[raddr1];
  assign rdata2 = wPref_rev_Matrix[raddr2];
endmodule