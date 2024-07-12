module multiplier_block_49 (
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
    w4,
    w2043,
    w32,
    w2011,
    w32176,
    w30165;
  assign w1 = i_data0;
  assign w2011 = w2043 - w32;
  assign w2043 = w2047 - w4;
  assign w2047 = w2048 - w1;
  assign w2048 = w1 << 11;
  assign w30165 = w32176 - w2011;
  assign w32 = w1 << 5;
  assign w32176 = w2011 << 4;
  assign w4 = w1 << 2;
  assign o_data0 = w30165;
endmodule