module constant_4ffad13294 (
  output [(8 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(8 - 1):0] const_value = 8'b00000110;
  assign op = 8'b00000110;
endmodule