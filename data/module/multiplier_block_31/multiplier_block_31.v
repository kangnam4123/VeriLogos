module multiplier_block_31 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w2048,
    w2047,
    w16,
    w17,
    w68,
    w2115,
    w8460,
    w6345;
  assign w1 = i_data0;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w2047 = w2048 - w1;
  assign w2048 = w1 << 11;
  assign w2115 = w2047 + w68;
  assign w6345 = w8460 - w2115;
  assign w68 = w17 << 2;
  assign w8460 = w2115 << 2;
  assign o_data0 = w6345;
endmodule