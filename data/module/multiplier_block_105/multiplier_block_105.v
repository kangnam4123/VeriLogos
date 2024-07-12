module multiplier_block_105 (
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
    w1024,
    w8991;
  assign w1 = i_data0;
  assign w1024 = w1 << 10;
  assign w31 = w32 - w1;
  assign w32 = w1 << 5;
  assign w7936 = w31 << 8;
  assign w7967 = w31 + w7936;
  assign w8991 = w7967 + w1024;
  assign o_data0 = w8991;
endmodule