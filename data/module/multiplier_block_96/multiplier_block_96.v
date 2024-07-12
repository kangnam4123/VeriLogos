module multiplier_block_96 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w16,
    w17,
    w2,
    w19,
    w19456,
    w19439;
  assign w1 = i_data0;
  assign w16 = w1 << 4;
  assign w17 = w1 + w16;
  assign w19 = w17 + w2;
  assign w19439 = w19456 - w17;
  assign w19456 = w19 << 10;
  assign w2 = w1 << 1;
  assign o_data0 = w19439;
endmodule