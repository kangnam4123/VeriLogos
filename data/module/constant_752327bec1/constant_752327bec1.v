module constant_752327bec1 (
  output [(6 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(6 - 1):0] const_value = 6'b011111;
  assign op = 6'b011111;
endmodule