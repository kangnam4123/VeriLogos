module Arbiter_20(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input         io_in_0_bits_valid,
  input  [26:0] io_in_0_bits_bits_addr,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [26:0] io_in_1_bits_bits_addr,
  input         io_in_1_bits_bits_need_gpa,
  input         io_out_ready,
  output        io_out_valid,
  output        io_out_bits_valid,
  output [26:0] io_out_bits_bits_addr,
  output        io_out_bits_bits_need_gpa,
  output [1:0]  io_chosen
);
  wire [1:0] _GEN_0 = io_in_1_valid ? 2'h1 : 2'h2; 
  wire  _GEN_3 = io_in_1_valid & io_in_1_bits_bits_need_gpa; 
  wire [26:0] _GEN_4 = io_in_1_valid ? io_in_1_bits_bits_addr : 27'h0; 
  wire  grant_1 = ~io_in_0_valid; 
  wire  grant_2 = ~(io_in_0_valid | io_in_1_valid); 
  assign io_in_0_ready = io_out_ready; 
  assign io_in_1_ready = grant_1 & io_out_ready; 
  assign io_out_valid = ~grant_2; 
  assign io_out_bits_valid = io_in_0_valid ? io_in_0_bits_valid : io_in_1_valid; 
  assign io_out_bits_bits_addr = io_in_0_valid ? io_in_0_bits_bits_addr : _GEN_4; 
  assign io_out_bits_bits_need_gpa = io_in_0_valid ? 1'h0 : _GEN_3; 
  assign io_chosen = io_in_0_valid ? 2'h0 : _GEN_0; 
endmodule