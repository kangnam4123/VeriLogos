module incif_1uint32_CEtable__0x07d3ba40(input CLK, input CE, input [32:0] process_input, output [31:0] process_output);
parameter INSTANCE_NAME="INST";
  wire [31:0] unnamedcast7797USEDMULTIPLEcast;assign unnamedcast7797USEDMULTIPLEcast = (process_input[31:0]); 
  assign process_output = (((process_input[32]))?({(unnamedcast7797USEDMULTIPLEcast+(32'd1))}):(unnamedcast7797USEDMULTIPLEcast));
endmodule