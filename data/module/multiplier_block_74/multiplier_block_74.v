module multiplier_block_74 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w256,
    w255,
    w32,
    w223,
    w7136,
    w7137;
  assign w1 = i_data0;
  assign w223 = w255 - w32;
  assign w255 = w256 - w1;
  assign w256 = w1 << 8;
  assign w32 = w1 << 5;
  assign w7136 = w223 << 5;
  assign w7137 = w1 + w7136;
  assign o_data0 = w7137;
endmodule