module multiplier_block_92 (
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
    w7936,
    w7967,
    w16,
    w7983,
    w2,
    w7981;
  assign w1 = i_data0;
  assign w16 = w1 << 4;
  assign w2 = w1 << 1;
  assign w31 = w32 - w1;
  assign w32 = w1 << 5;
  assign w7936 = w31 << 8;
  assign w7967 = w31 + w7936;
  assign w7981 = w7983 - w2;
  assign w7983 = w7967 + w16;
  assign o_data0 = w7981;
endmodule