module ClockGroup_4(
  input   auto_in_member_subsystem_mbus_0_clock,
  input   auto_in_member_subsystem_mbus_0_reset,
  output  auto_out_clock,
  output  auto_out_reset
);
  assign auto_out_clock = auto_in_member_subsystem_mbus_0_clock; 
  assign auto_out_reset = auto_in_member_subsystem_mbus_0_reset; 
endmodule