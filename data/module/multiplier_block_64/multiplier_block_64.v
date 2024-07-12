module multiplier_block_64 (
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
    w8192,
    w24575,
    w4,
    w5,
    w40,
    w24535;
  assign w1 = i_data0;
  assign w16383 = w16384 - w1;
  assign w16384 = w1 << 14;
  assign w24535 = w24575 - w40;
  assign w24575 = w16383 + w8192;
  assign w4 = w1 << 2;
  assign w40 = w5 << 3;
  assign w5 = w1 + w4;
  assign w8192 = w1 << 13;
  assign o_data0 = w24535;
endmodule