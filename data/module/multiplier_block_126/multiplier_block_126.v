module multiplier_block_126 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w256,
    w255,
    w8160,
    w8159,
    w64,
    w8095,
    w1020,
    w7075,
    w14150;
  assign w1 = i_data0;
  assign w1020 = w255 << 2;
  assign w14150 = w7075 << 1;
  assign w255 = w256 - w1;
  assign w256 = w1 << 8;
  assign w64 = w1 << 6;
  assign w7075 = w8095 - w1020;
  assign w8095 = w8159 - w64;
  assign w8159 = w8160 - w1;
  assign w8160 = w255 << 5;
  assign o_data0 = w14150;
endmodule