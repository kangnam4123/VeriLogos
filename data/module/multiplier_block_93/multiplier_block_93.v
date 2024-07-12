module multiplier_block_93 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w4096,
    w4095,
    w128,
    w4223,
    w16892,
    w21115,
    w16,
    w21099,
    w256,
    w20843;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w16 = w1 << 4;
  assign w16892 = w4223 << 2;
  assign w20843 = w21099 - w256;
  assign w21099 = w21115 - w16;
  assign w21115 = w4223 + w16892;
  assign w256 = w1 << 8;
  assign w4095 = w4096 - w1;
  assign w4096 = w1 << 12;
  assign w4223 = w4095 + w128;
  assign o_data0 = w20843;
endmodule