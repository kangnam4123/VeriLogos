module sumwrap_uint16_to1_1(input CLK, input CE, input [31:0] process_input, output [15:0] process_output);
parameter INSTANCE_NAME="INST";
  wire [15:0] unnamedcast112USEDMULTIPLEcast;assign unnamedcast112USEDMULTIPLEcast = (process_input[15:0]); 
  assign process_output = (({(unnamedcast112USEDMULTIPLEcast==(16'd1))})?((16'd0)):({(unnamedcast112USEDMULTIPLEcast+(process_input[31:16]))}));
endmodule