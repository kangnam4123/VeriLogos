module packTupleArrays_table__0x060ff220(input CLK, input process_CE, input [335:0] process_input, output [335:0] process_output);
parameter INSTANCE_NAME="INST";
  wire [167:0] unnamedcast1357USEDMULTIPLEcast;assign unnamedcast1357USEDMULTIPLEcast = (process_input[167:0]); 
  wire [167:0] unnamedcast1361USEDMULTIPLEcast;assign unnamedcast1361USEDMULTIPLEcast = (process_input[335:168]); 
  assign process_output = {{({unnamedcast1361USEDMULTIPLEcast[167:160]}),({unnamedcast1357USEDMULTIPLEcast[167:160]})},{({unnamedcast1361USEDMULTIPLEcast[159:152]}),({unnamedcast1357USEDMULTIPLEcast[159:152]})},{({unnamedcast1361USEDMULTIPLEcast[151:144]}),({unnamedcast1357USEDMULTIPLEcast[151:144]})},{({unnamedcast1361USEDMULTIPLEcast[143:136]}),({unnamedcast1357USEDMULTIPLEcast[143:136]})},{({unnamedcast1361USEDMULTIPLEcast[135:128]}),({unnamedcast1357USEDMULTIPLEcast[135:128]})},{({unnamedcast1361USEDMULTIPLEcast[127:120]}),({unnamedcast1357USEDMULTIPLEcast[127:120]})},{({unnamedcast1361USEDMULTIPLEcast[119:112]}),({unnamedcast1357USEDMULTIPLEcast[119:112]})},{({unnamedcast1361USEDMULTIPLEcast[111:104]}),({unnamedcast1357USEDMULTIPLEcast[111:104]})},{({unnamedcast1361USEDMULTIPLEcast[103:96]}),({unnamedcast1357USEDMULTIPLEcast[103:96]})},{({unnamedcast1361USEDMULTIPLEcast[95:88]}),({unnamedcast1357USEDMULTIPLEcast[95:88]})},{({unnamedcast1361USEDMULTIPLEcast[87:80]}),({unnamedcast1357USEDMULTIPLEcast[87:80]})},{({unnamedcast1361USEDMULTIPLEcast[79:72]}),({unnamedcast1357USEDMULTIPLEcast[79:72]})},{({unnamedcast1361USEDMULTIPLEcast[71:64]}),({unnamedcast1357USEDMULTIPLEcast[71:64]})},{({unnamedcast1361USEDMULTIPLEcast[63:56]}),({unnamedcast1357USEDMULTIPLEcast[63:56]})},{({unnamedcast1361USEDMULTIPLEcast[55:48]}),({unnamedcast1357USEDMULTIPLEcast[55:48]})},{({unnamedcast1361USEDMULTIPLEcast[47:40]}),({unnamedcast1357USEDMULTIPLEcast[47:40]})},{({unnamedcast1361USEDMULTIPLEcast[39:32]}),({unnamedcast1357USEDMULTIPLEcast[39:32]})},{({unnamedcast1361USEDMULTIPLEcast[31:24]}),({unnamedcast1357USEDMULTIPLEcast[31:24]})},{({unnamedcast1361USEDMULTIPLEcast[23:16]}),({unnamedcast1357USEDMULTIPLEcast[23:16]})},{({unnamedcast1361USEDMULTIPLEcast[15:8]}),({unnamedcast1357USEDMULTIPLEcast[15:8]})},{({unnamedcast1361USEDMULTIPLEcast[7:0]}),({unnamedcast1357USEDMULTIPLEcast[7:0]})}};
endmodule