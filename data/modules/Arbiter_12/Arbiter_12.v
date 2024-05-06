module Arbiter_12(
  input         io_in_0_valid,
  input  [7:0]  io_in_0_bits_req_0_way_en,
  input  [11:0] io_in_0_bits_req_0_addr,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [7:0]  io_in_1_bits_req_0_way_en,
  input  [11:0] io_in_1_bits_req_0_addr,
  output        io_in_2_ready,
  input         io_in_2_valid,
  input  [11:0] io_in_2_bits_req_0_addr,
  input  [11:0] io_in_2_bits_req_1_addr,
  input         io_in_2_bits_valid_0,
  input         io_in_2_bits_valid_1,
  output        io_out_valid,
  output [7:0]  io_out_bits_req_0_way_en,
  output [11:0] io_out_bits_req_0_addr,
  output [7:0]  io_out_bits_req_1_way_en,
  output [11:0] io_out_bits_req_1_addr,
  output        io_out_bits_valid_0,
  output        io_out_bits_valid_1
);
  wire  _GEN_1 = io_in_1_valid | io_in_2_bits_valid_0; 
  wire  _GEN_2 = io_in_1_valid ? 1'h0 : io_in_2_bits_valid_1; 
  wire [11:0] _GEN_3 = io_in_1_valid ? io_in_1_bits_req_0_addr : io_in_2_bits_req_0_addr; 
  wire [7:0] _GEN_4 = io_in_1_valid ? io_in_1_bits_req_0_way_en : 8'hff; 
  wire [11:0] _GEN_5 = io_in_1_valid ? 12'h0 : io_in_2_bits_req_1_addr; 
  wire [7:0] _GEN_6 = io_in_1_valid ? 8'h0 : 8'hff; 
  wire  grant_2 = ~(io_in_0_valid | io_in_1_valid); 
  assign io_in_1_ready = ~io_in_0_valid; 
  assign io_in_2_ready = ~(io_in_0_valid | io_in_1_valid); 
  assign io_out_valid = ~grant_2 | io_in_2_valid; 
  assign io_out_bits_req_0_way_en = io_in_0_valid ? io_in_0_bits_req_0_way_en : _GEN_4; 
  assign io_out_bits_req_0_addr = io_in_0_valid ? io_in_0_bits_req_0_addr : _GEN_3; 
  assign io_out_bits_req_1_way_en = io_in_0_valid ? 8'h0 : _GEN_6; 
  assign io_out_bits_req_1_addr = io_in_0_valid ? 12'h0 : _GEN_5; 
  assign io_out_bits_valid_0 = io_in_0_valid | _GEN_1; 
  assign io_out_bits_valid_1 = io_in_0_valid ? 1'h0 : _GEN_2; 
endmodule