module constant_67d0b5242e (
  output [(8 - 1):0] op,
  input clk,
  input ce,
  input clr);
  localparam [(8 - 1):0] const_value = 8'b00000010;
  assign op = 8'b00000010;
endmodule