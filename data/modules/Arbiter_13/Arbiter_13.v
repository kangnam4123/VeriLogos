module Arbiter_13(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [19:0] io_in_0_bits_tag,
  input  [5:0]  io_in_0_bits_idx,
  input  [2:0]  io_in_0_bits_param,
  input  [7:0]  io_in_0_bits_way_en,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [19:0] io_in_1_bits_tag,
  input  [5:0]  io_in_1_bits_idx,
  input  [2:0]  io_in_1_bits_param,
  input  [7:0]  io_in_1_bits_way_en,
  input         io_out_ready,
  output        io_out_valid,
  output [19:0] io_out_bits_tag,
  output [5:0]  io_out_bits_idx,
  output [2:0]  io_out_bits_param,
  output [7:0]  io_out_bits_way_en,
  output        io_out_bits_voluntary
);
  wire  grant_1 = ~io_in_0_valid; 
  assign io_in_0_ready = io_out_ready; 
  assign io_in_1_ready = grant_1 & io_out_ready; 
  assign io_out_valid = ~grant_1 | io_in_1_valid; 
  assign io_out_bits_tag = io_in_0_valid ? io_in_0_bits_tag : io_in_1_bits_tag; 
  assign io_out_bits_idx = io_in_0_valid ? io_in_0_bits_idx : io_in_1_bits_idx; 
  assign io_out_bits_param = io_in_0_valid ? io_in_0_bits_param : io_in_1_bits_param; 
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_bits_way_en; 
  assign io_out_bits_voluntary = io_in_0_valid ? 1'h0 : 1'h1; 
endmodule