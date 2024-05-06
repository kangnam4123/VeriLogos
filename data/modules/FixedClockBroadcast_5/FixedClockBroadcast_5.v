module FixedClockBroadcast_5(
  input   auto_in_clock,
  input   auto_in_reset,
  output  auto_out_clock,
  output  auto_out_reset
);
  assign auto_out_clock = auto_in_clock; 
  assign auto_out_reset = auto_in_reset; 
endmodule