module multiplier_block_34 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w16384,
    w16383,
    w4096,
    w20479,
    w128,
    w20351;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w16383 = w16384 - w1;
  assign w16384 = w1 << 14;
  assign w20351 = w20479 - w128;
  assign w20479 = w16383 + w4096;
  assign w4096 = w1 << 12;
  assign o_data0 = w20351;
endmodule