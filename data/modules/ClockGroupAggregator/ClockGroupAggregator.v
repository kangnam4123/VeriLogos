module ClockGroupAggregator(
  input   auto_in_member_subsystem_sbus_1_clock,
  input   auto_in_member_subsystem_sbus_1_reset,
  input   auto_in_member_subsystem_sbus_0_clock,
  input   auto_in_member_subsystem_sbus_0_reset,
  output  auto_out_1_member_subsystem_l2_0_clock,
  output  auto_out_1_member_subsystem_l2_0_reset,
  output  auto_out_0_member_subsystem_sbus_0_clock,
  output  auto_out_0_member_subsystem_sbus_0_reset
);
  assign auto_out_1_member_subsystem_l2_0_clock = auto_in_member_subsystem_sbus_1_clock; 
  assign auto_out_1_member_subsystem_l2_0_reset = auto_in_member_subsystem_sbus_1_reset; 
  assign auto_out_0_member_subsystem_sbus_0_clock = auto_in_member_subsystem_sbus_0_clock; 
  assign auto_out_0_member_subsystem_sbus_0_reset = auto_in_member_subsystem_sbus_0_reset; 
endmodule