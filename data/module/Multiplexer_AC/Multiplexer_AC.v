module Multiplexer_AC
  # (parameter W = 32)
  (
    input wire ctrl,
    input wire [W-1:0] D0,
    input wire [W-1:0] D1,
    output reg [W-1:0] S
    );
   always @(ctrl, D0, D1)
      case (ctrl)
         1'b0: S <= D0;
         1'b1: S <= D1;
      endcase
endmodule