module multiplier_block_62 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w128,
    w129,
    w16384,
    w16513,
    w2064,
    w18577,
    w516,
    w19093;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w129 = w1 + w128;
  assign w16384 = w1 << 14;
  assign w16513 = w129 + w16384;
  assign w18577 = w16513 + w2064;
  assign w19093 = w18577 + w516;
  assign w2064 = w129 << 4;
  assign w516 = w129 << 2;
  assign o_data0 = w19093;
endmodule