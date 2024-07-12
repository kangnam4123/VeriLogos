module multiplier_block_9 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w128,
    w129,
    w4,
    w133,
    w2064,
    w1931,
    w30896;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w129 = w1 + w128;
  assign w133 = w129 + w4;
  assign w1931 = w2064 - w133;
  assign w2064 = w129 << 4;
  assign w30896 = w1931 << 4;
  assign w4 = w1 << 2;
  assign o_data0 = w30896;
endmodule