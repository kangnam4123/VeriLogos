module incif_wrapuint16_646_inc2(input CLK, input CE, input [16:0] process_input, output [15:0] process_output);
parameter INSTANCE_NAME="INST";
  wire [15:0] unnamedcast3597USEDMULTIPLEcast;assign unnamedcast3597USEDMULTIPLEcast = (process_input[15:0]); 
  assign process_output = (((process_input[16]))?((({(unnamedcast3597USEDMULTIPLEcast==(16'd646))})?((16'd0)):({(unnamedcast3597USEDMULTIPLEcast+(16'd2))}))):(unnamedcast3597USEDMULTIPLEcast));
endmodule