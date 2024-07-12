module multiplier_block_113 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w32,
    w31,
    w496,
    w527,
    w62,
    w589,
    w18848;
  assign w1 = i_data0;
  assign w18848 = w589 << 5;
  assign w31 = w32 - w1;
  assign w32 = w1 << 5;
  assign w496 = w31 << 4;
  assign w527 = w31 + w496;
  assign w589 = w527 + w62;
  assign w62 = w31 << 1;
  assign o_data0 = w18848;
endmodule