module multiplier_block_106 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w256,
    w257,
    w4112,
    w4369,
    w2,
    w4367,
    w64,
    w4431,
    w8862;
  assign w1 = i_data0;
  assign w2 = w1 << 1;
  assign w256 = w1 << 8;
  assign w257 = w1 + w256;
  assign w4112 = w257 << 4;
  assign w4367 = w4369 - w2;
  assign w4369 = w257 + w4112;
  assign w4431 = w4367 + w64;
  assign w64 = w1 << 6;
  assign w8862 = w4431 << 1;
  assign o_data0 = w8862;
endmodule