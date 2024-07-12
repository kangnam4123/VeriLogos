module multiplier_block_57 (
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
    w16512,
    w16511,
    w32,
    w16479;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w129 = w1 + w128;
  assign w16479 = w16511 - w32;
  assign w16511 = w16512 - w1;
  assign w16512 = w129 << 7;
  assign w32 = w1 << 5;
  assign o_data0 = w16479;
endmodule