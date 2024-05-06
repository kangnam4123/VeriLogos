module ClockGroup_6(
  input   auto_in_member_chipyardPRCI_implicit_clock_clock,
  input   auto_in_member_chipyardPRCI_implicit_clock_reset,
  output  auto_out_clock,
  output  auto_out_reset
);
  assign auto_out_clock = auto_in_member_chipyardPRCI_implicit_clock_clock; 
  assign auto_out_reset = auto_in_member_chipyardPRCI_implicit_clock_reset; 
endmodule