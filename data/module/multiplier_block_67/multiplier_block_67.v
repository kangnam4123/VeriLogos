module multiplier_block_67 (
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
    w2,
    w1021,
    w32,
    w1055,
    w4084,
    w3029,
    w24232;
  assign w1 = i_data0;
  assign w1021 = w1023 - w2;
  assign w1023 = w1024 - w1;
  assign w1024 = w1 << 10;
  assign w1055 = w1023 + w32;
  assign w2 = w1 << 1;
  assign w24232 = w3029 << 3;
  assign w3029 = w4084 - w1055;
  assign w32 = w1 << 5;
  assign w4084 = w1021 << 2;
  assign o_data0 = w24232;
endmodule