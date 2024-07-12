module multiplier_block_71 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w8,
    w9,
    w32768,
    w32777,
    w288,
    w33065,
    w1024,
    w32041;
  assign w1 = i_data0;
  assign w1024 = w1 << 10;
  assign w288 = w9 << 5;
  assign w32041 = w33065 - w1024;
  assign w32768 = w1 << 15;
  assign w32777 = w9 + w32768;
  assign w33065 = w32777 + w288;
  assign w8 = w1 << 3;
  assign w9 = w1 + w8;
  assign o_data0 = w32041;
endmodule