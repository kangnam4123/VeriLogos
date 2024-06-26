module TLBuffer_3(
  output        auto_in_a_ready,
  input         auto_in_a_valid,
  input  [2:0]  auto_in_a_bits_opcode,
  input  [2:0]  auto_in_a_bits_param,
  input  [2:0]  auto_in_a_bits_size,
  input  [2:0]  auto_in_a_bits_source,
  input  [14:0] auto_in_a_bits_address,
  input  [3:0]  auto_in_a_bits_mask,
  input  [31:0] auto_in_a_bits_data,
  input         auto_in_a_bits_corrupt,
  input         auto_in_d_ready,
  output        auto_in_d_valid,
  output [2:0]  auto_in_d_bits_opcode,
  output [2:0]  auto_in_d_bits_size,
  output [2:0]  auto_in_d_bits_source,
  output [31:0] auto_in_d_bits_data,
  input         auto_out_a_ready,
  output        auto_out_a_valid,
  output [2:0]  auto_out_a_bits_opcode,
  output [2:0]  auto_out_a_bits_param,
  output [2:0]  auto_out_a_bits_size,
  output [2:0]  auto_out_a_bits_source,
  output [14:0] auto_out_a_bits_address,
  output [3:0]  auto_out_a_bits_mask,
  output [31:0] auto_out_a_bits_data,
  output        auto_out_a_bits_corrupt,
  output        auto_out_d_ready,
  input         auto_out_d_valid,
  input  [2:0]  auto_out_d_bits_opcode,
  input  [2:0]  auto_out_d_bits_size,
  input  [2:0]  auto_out_d_bits_source,
  input  [31:0] auto_out_d_bits_data
);
  assign auto_in_a_ready = auto_out_a_ready; 
  assign auto_in_d_valid = auto_out_d_valid; 
  assign auto_in_d_bits_opcode = auto_out_d_bits_opcode; 
  assign auto_in_d_bits_size = auto_out_d_bits_size; 
  assign auto_in_d_bits_source = auto_out_d_bits_source; 
  assign auto_in_d_bits_data = auto_out_d_bits_data; 
  assign auto_out_a_valid = auto_in_a_valid; 
  assign auto_out_a_bits_opcode = auto_in_a_bits_opcode; 
  assign auto_out_a_bits_param = auto_in_a_bits_param; 
  assign auto_out_a_bits_size = auto_in_a_bits_size; 
  assign auto_out_a_bits_source = auto_in_a_bits_source; 
  assign auto_out_a_bits_address = auto_in_a_bits_address; 
  assign auto_out_a_bits_mask = auto_in_a_bits_mask; 
  assign auto_out_a_bits_data = auto_in_a_bits_data; 
  assign auto_out_a_bits_corrupt = auto_in_a_bits_corrupt; 
  assign auto_out_d_ready = auto_in_d_ready; 
endmodule