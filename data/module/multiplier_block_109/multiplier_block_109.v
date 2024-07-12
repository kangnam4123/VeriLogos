module multiplier_block_109 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w1024,
    w1023,
    w64,
    w959,
    w256,
    w703,
    w16,
    w687;
  assign w1 = i_data0;
  assign w1023 = w1024 - w1;
  assign w1024 = w1 << 10;
  assign w16 = w1 << 4;
  assign w256 = w1 << 8;
  assign w64 = w1 << 6;
  assign w687 = w703 - w16;
  assign w703 = w959 - w256;
  assign w959 = w1023 - w64;
  assign o_data0 = w687;
endmodule