module multiplier_block_18 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w4,
    w5,
    w128,
    w127,
    w20,
    w107,
    w13696,
    w13589,
    w27178;
  assign w1 = i_data0;
  assign w107 = w127 - w20;
  assign w127 = w128 - w1;
  assign w128 = w1 << 7;
  assign w13589 = w13696 - w107;
  assign w13696 = w107 << 7;
  assign w20 = w5 << 2;
  assign w27178 = w13589 << 1;
  assign w4 = w1 << 2;
  assign w5 = w1 + w4;
  assign o_data0 = w27178;
endmodule