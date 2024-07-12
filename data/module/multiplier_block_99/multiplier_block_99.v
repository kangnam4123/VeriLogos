module multiplier_block_99 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w512,
    w511,
    w2044,
    w2045,
    w16,
    w2061,
    w8244,
    w7733;
  assign w1 = i_data0;
  assign w16 = w1 << 4;
  assign w2044 = w511 << 2;
  assign w2045 = w1 + w2044;
  assign w2061 = w2045 + w16;
  assign w511 = w512 - w1;
  assign w512 = w1 << 9;
  assign w7733 = w8244 - w511;
  assign w8244 = w2061 << 2;
  assign o_data0 = w7733;
endmodule