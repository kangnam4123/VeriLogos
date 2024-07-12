module multiplier_block_78 (
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
    w4,
    w133,
    w1024,
    w891,
    w3564;
  assign w1 = i_data0;
  assign w1024 = w1 << 10;
  assign w128 = w1 << 7;
  assign w129 = w1 + w128;
  assign w133 = w129 + w4;
  assign w3564 = w891 << 2;
  assign w4 = w1 << 2;
  assign w891 = w1024 - w133;
  assign o_data0 = w3564;
endmodule