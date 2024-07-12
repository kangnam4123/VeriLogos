module multiplier_block_88 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w4096,
    w4095,
    w256,
    w4351,
    w32,
    w4383,
    w2,
    w4381,
    w8762;
  assign w1 = i_data0;
  assign w2 = w1 << 1;
  assign w256 = w1 << 8;
  assign w32 = w1 << 5;
  assign w4095 = w4096 - w1;
  assign w4096 = w1 << 12;
  assign w4351 = w4095 + w256;
  assign w4381 = w4383 - w2;
  assign w4383 = w4351 + w32;
  assign w8762 = w4381 << 1;
  assign o_data0 = w8762;
endmodule