module multiplier_block_69 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w256,
    w257,
    w4,
    w261,
    w32,
    w229,
    w29312;
  assign w1 = i_data0;
  assign w229 = w261 - w32;
  assign w256 = w1 << 8;
  assign w257 = w1 + w256;
  assign w261 = w257 + w4;
  assign w29312 = w229 << 7;
  assign w32 = w1 << 5;
  assign w4 = w1 << 2;
  assign o_data0 = w29312;
endmodule