module multiplier_block_30 (
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
    w16384,
    w16353,
    w8192,
    w24545,
    w496,
    w25041;
  assign w1 = i_data0;
  assign w16353 = w16384 - w31;
  assign w16384 = w1 << 14;
  assign w24545 = w16353 + w8192;
  assign w25041 = w24545 + w496;
  assign w31 = w32 - w1;
  assign w32 = w1 << 5;
  assign w496 = w31 << 4;
  assign w8192 = w1 << 13;
  assign o_data0 = w25041;
endmodule