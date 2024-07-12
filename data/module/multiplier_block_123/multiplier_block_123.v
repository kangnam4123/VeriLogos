module multiplier_block_123 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w8,
    w9,
    w16,
    w25,
    w6400,
    w6409,
    w12818;
  assign w1 = i_data0;
  assign w12818 = w6409 << 1;
  assign w16 = w1 << 4;
  assign w25 = w9 + w16;
  assign w6400 = w25 << 8;
  assign w6409 = w9 + w6400;
  assign w8 = w1 << 3;
  assign w9 = w1 + w8;
  assign o_data0 = w12818;
endmodule