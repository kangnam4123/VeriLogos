module ZeroComparator_0x422b1f52edd46a85
(
  input  wire [   0:0] clock,
  input  wire [  15:0] in_,
  output reg  [   0:0] out,
  input  wire [   0:0] reset
);
  always @ (*) begin
    out = (in_ == 0);
  end
endmodule