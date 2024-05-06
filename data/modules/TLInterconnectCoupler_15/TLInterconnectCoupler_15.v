module TLInterconnectCoupler_15(
  output        auto_tl_in_a_ready,
  input         auto_tl_in_a_valid,
  input  [31:0] auto_tl_in_a_bits_address,
  input  [31:0] auto_tl_in_a_bits_data,
  output        auto_tl_in_d_valid,
  input         auto_tl_out_a_ready,
  output        auto_tl_out_a_valid,
  output [31:0] auto_tl_out_a_bits_address,
  output [31:0] auto_tl_out_a_bits_data,
  input         auto_tl_out_d_valid
);
  assign auto_tl_in_a_ready = auto_tl_out_a_ready; 
  assign auto_tl_in_d_valid = auto_tl_out_d_valid; 
  assign auto_tl_out_a_valid = auto_tl_in_a_valid; 
  assign auto_tl_out_a_bits_address = auto_tl_in_a_bits_address; 
  assign auto_tl_out_a_bits_data = auto_tl_in_a_bits_data; 
endmodule