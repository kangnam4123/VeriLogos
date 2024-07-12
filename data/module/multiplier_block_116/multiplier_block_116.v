module multiplier_block_116 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w512,
    w513,
    w128,
    w385,
    w16384,
    w15999,
    w6160,
    w22159;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w15999 = w16384 - w385;
  assign w16384 = w1 << 14;
  assign w22159 = w15999 + w6160;
  assign w385 = w513 - w128;
  assign w512 = w1 << 9;
  assign w513 = w1 + w512;
  assign w6160 = w385 << 4;
  assign o_data0 = w22159;
endmodule