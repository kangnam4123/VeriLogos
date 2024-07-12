module multiplier_block_55 (
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
    w4104,
    w3591,
    w64,
    w65,
    w7182,
    w7117;
  assign w1 = i_data0;
  assign w3591 = w4104 - w513;
  assign w4104 = w513 << 3;
  assign w512 = w1 << 9;
  assign w513 = w1 + w512;
  assign w64 = w1 << 6;
  assign w65 = w1 + w64;
  assign w7117 = w7182 - w65;
  assign w7182 = w3591 << 1;
  assign o_data0 = w7117;
endmodule