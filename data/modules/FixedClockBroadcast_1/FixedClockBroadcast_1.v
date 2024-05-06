module FixedClockBroadcast_1(
  input   auto_in_clock,
  input   auto_in_reset,
  output  auto_out_1_clock,
  output  auto_out_1_reset,
  output  auto_out_0_clock,
  output  auto_out_0_reset
);
  assign auto_out_1_clock = auto_in_clock; 
  assign auto_out_1_reset = auto_in_reset; 
  assign auto_out_0_clock = auto_in_clock; 
  assign auto_out_0_reset = auto_in_reset; 
endmodule