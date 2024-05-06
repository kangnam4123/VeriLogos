module Arbiter_14(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_address,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_address,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_address
);
  wire  grant_1 = ~io_in_0_valid; 
  assign io_in_0_ready = io_out_ready; 
  assign io_in_1_ready = grant_1 & io_out_ready; 
  assign io_out_valid = ~grant_1 | io_in_1_valid; 
  assign io_out_bits_address = io_in_0_valid ? io_in_0_bits_address : io_in_1_bits_address; 
endmodule