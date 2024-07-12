module multiplier_block_77 (
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
    w4,
    w5,
    w8160,
    w8415,
    w10,
    w8405;
  assign w1 = i_data0;
  assign w10 = w5 << 1;
  assign w255 = w256 - w1;
  assign w256 = w1 << 8;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign w8160 = w255 << 5;
  assign w8405 = w8415 - w10;
  assign w8415 = w255 + w8160;
  assign o_data0 = w8405;
endmodule