module Arbiter_11(
  input          io_in_0_valid,
  input  [7:0]   io_in_0_bits_way_en,
  input  [11:0]  io_in_0_bits_addr,
  input  [1:0]   io_in_0_bits_wmask,
  input  [127:0] io_in_0_bits_data,
  output         io_in_1_ready,
  input          io_in_1_valid,
  input  [7:0]   io_in_1_bits_way_en,
  input  [11:0]  io_in_1_bits_addr,
  input  [127:0] io_in_1_bits_data,
  input          io_out_ready,
  output         io_out_valid,
  output [7:0]   io_out_bits_way_en,
  output [11:0]  io_out_bits_addr,
  output [1:0]   io_out_bits_wmask,
  output [127:0] io_out_bits_data
);
  wire  grant_1 = ~io_in_0_valid; 
  assign io_in_1_ready = ~io_in_0_valid; 
  assign io_out_valid = ~grant_1 | io_in_1_valid; 
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : io_in_1_bits_way_en; 
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : io_in_1_bits_addr; 
  assign io_out_bits_wmask = io_in_0_valid ? io_in_0_bits_wmask : 2'h3; 
  assign io_out_bits_data = io_in_0_valid ? io_in_0_bits_data : io_in_1_bits_data; 
endmodule