module ShiftRegister_0_CEtrue_TY1(input CLK, input CE, input sr_input, output pushPop_out);
parameter INSTANCE_NAME="INST";
  assign pushPop_out = sr_input;
endmodule