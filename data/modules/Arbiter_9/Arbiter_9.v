module Arbiter_9(
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [5:0]  io_in_0_bits_idx,
  input  [7:0]  io_in_0_bits_way_en,
  input  [1:0]  io_in_0_bits_data_coh_state,
  input  [19:0] io_in_0_bits_data_tag,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [5:0]  io_in_1_bits_idx,
  input  [7:0]  io_in_1_bits_way_en,
  input  [1:0]  io_in_1_bits_data_coh_state,
  input  [19:0] io_in_1_bits_data_tag,
  input         io_out_ready,
  output        io_out_valid,
  output [5:0]  io_out_bits_idx,
  output [7:0]  io_out_bits_way_en,
  output [1:0]  io_out_bits_data_coh_state,
  output [19:0] io_out_bits_data_tag
);
  wire  grant_1 = ~io_in_0_valid; 
  assign io_in_0_ready = io_out_ready; 
  assign io_in_1_ready = grant_1 & io_out_ready; 
  assign io_out_valid = ~grant_1 | io_in_1_valid; 
  assign io_out_bits_idx = io_in_0_valid ? io_in_0_bits_idx : io_in_1_bits_idx; 
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_bits_way_en; 
  assign io_out_bits_data_coh_state = io_in_0_valid ? io_in_0_bits_data_coh_state : io_in_1_bits_data_coh_state; 
  assign io_out_bits_data_tag = io_in_0_valid ? io_in_0_bits_data_tag : io_in_1_bits_data_tag; 
endmodule