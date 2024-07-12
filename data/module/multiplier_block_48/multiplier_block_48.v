module multiplier_block_48 (
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
    w16416,
    w16801,
    w6160,
    w6159,
    w33602,
    w27443;
  assign w1 = i_data0;
  assign w128 = w1 << 7;
  assign w16416 = w513 << 5;
  assign w16801 = w385 + w16416;
  assign w27443 = w33602 - w6159;
  assign w33602 = w16801 << 1;
  assign w385 = w513 - w128;
  assign w512 = w1 << 9;
  assign w513 = w1 + w512;
  assign w6159 = w6160 - w1;
  assign w6160 = w385 << 4;
  assign o_data0 = w27443;
endmodule