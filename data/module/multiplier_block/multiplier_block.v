module multiplier_block (
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
    w992,
    w961,
    w256,
    w705,
    w1410,
    w2371,
    w9484;
  assign w1 = i_data0;
  assign w1410 = w705 << 1;
  assign w2371 = w961 + w1410;
  assign w256 = w1 << 8;
  assign w31 = w32 - w1;
  assign w32 = w1 << 5;
  assign w705 = w961 - w256;
  assign w9484 = w2371 << 2;
  assign w961 = w992 - w31;
  assign w992 = w31 << 5;
  assign o_data0 = w9484;
endmodule