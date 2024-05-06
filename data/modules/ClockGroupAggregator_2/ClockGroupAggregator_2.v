module ClockGroupAggregator_2(
  input   auto_in_member_subsystem_fbus_0_clock,
  input   auto_in_member_subsystem_fbus_0_reset,
  output  auto_out_member_subsystem_fbus_0_clock,
  output  auto_out_member_subsystem_fbus_0_reset
);
  assign auto_out_member_subsystem_fbus_0_clock = auto_in_member_subsystem_fbus_0_clock; 
  assign auto_out_member_subsystem_fbus_0_reset = auto_in_member_subsystem_fbus_0_reset; 
endmodule