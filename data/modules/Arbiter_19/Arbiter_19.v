module Arbiter_19(
  input        io_in_0_valid,
  input  [5:0] io_in_0_bits,
  input        io_in_1_valid,
  input  [5:0] io_in_1_bits,
  output       io_in_2_ready,
  input  [5:0] io_in_2_bits,
  output [5:0] io_out_bits
);
  wire [5:0] _GEN_1 = io_in_1_valid ? io_in_1_bits : io_in_2_bits; 
  assign io_in_2_ready = ~(io_in_0_valid | io_in_1_valid); 
  assign io_out_bits = io_in_0_valid ? io_in_0_bits : _GEN_1; 
endmodule