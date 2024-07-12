module multiplier_block_102 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w2048,
    w2049,
    w128,
    w1921,
    w16,
    w1937,
    w4,
    w1941,
    w31056;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w16 = w1 << 4;
  assign w1921 = w2049 - w128;
  assign w1937 = w1921 + w16;
  assign w1941 = w1937 + w4;
  assign w2048 = w1 << 11;
  assign w2049 = w1 + w2048;
  assign w31056 = w1941 << 4;
  assign w4 = w1 << 2;
  assign o_data0 = w31056;
endmodule