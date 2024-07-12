module multiplier_block_33 (
    i_data0,
    o_data0
);
  input   [31:0] i_data0;
  output  [31:0]
    o_data0;
  wire [31:0]
    w1,
    w4,
    w3,
    w192,
    w189,
    w32768,
    w32579;
  assign w1 = i_data0;
  assign w189 = w192 - w3;
  assign w192 = w3 << 6;
  assign w3 = w4 - w1;
  assign w32579 = w32768 - w189;
  assign w32768 = w1 << 15;
  assign w4 = w1 << 2;
  assign o_data0 = w32579;
endmodule