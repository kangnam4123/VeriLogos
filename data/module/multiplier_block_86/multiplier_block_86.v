module multiplier_block_86 (
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
    w2064,
    w2193,
    w516,
    w2709,
    w8,
    w2701,
    w21608;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w129 = w1 + w128;
  assign w2064 = w129 << 4;
  assign w21608 = w2701 << 3;
  assign w2193 = w129 + w2064;
  assign w2701 = w2709 - w8;
  assign w2709 = w2193 + w516;
  assign w516 = w129 << 2;
  assign w8 = w1 << 3;
  assign o_data0 = w21608;
endmodule