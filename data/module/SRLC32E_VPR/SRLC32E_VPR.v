module SRLC32E_VPR
(
input CLK, CE, D,
input [4:0] A,
output Q, Q31
);
  parameter [64:0] INIT = 64'd0;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;
  reg [31:0] r;
  integer i;
  initial for (i=0; i<32; i=i+1)
    r[i] <= INIT[2*i];
  assign Q31 = r[31];
  assign Q = r[A];
  generate begin
    if (IS_CLK_INVERTED) begin
      always @(negedge CLK) if (CE) r <= { r[30:0], D };
    end else begin
      always @(posedge CLK) if (CE) r <= { r[30:0], D };
    end
  end endgenerate
endmodule