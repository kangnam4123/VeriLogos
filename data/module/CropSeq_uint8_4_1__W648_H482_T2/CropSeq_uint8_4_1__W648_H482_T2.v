module CropSeq_uint8_4_1__W648_H482_T2(input CLK, input process_CE, input [127:0] process_input, output [64:0] process_output);
parameter INSTANCE_NAME="INST";
  reg [63:0] unnamedcast5522_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast5522_delay1_validunnamednull0_CEprocess_CE <= (process_input[127:64]); end end
  reg [63:0] unnamedcast5522_delay2_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast5522_delay2_validunnamednull0_CEprocess_CE <= unnamedcast5522_delay1_validunnamednull0_CEprocess_CE; end end
  reg [63:0] unnamedcast5522_delay3_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast5522_delay3_validunnamednull0_CEprocess_CE <= unnamedcast5522_delay2_validunnamednull0_CEprocess_CE; end end
  wire [63:0] unnamedcast5524;assign unnamedcast5524 = (process_input[63:0]);  
  wire [31:0] unnamedcast5526USEDMULTIPLEcast;assign unnamedcast5526USEDMULTIPLEcast = ({unnamedcast5524[31:0]}); 
  wire [15:0] unnamedcast5528USEDMULTIPLEcast;assign unnamedcast5528USEDMULTIPLEcast = (unnamedcast5526USEDMULTIPLEcast[15:0]); 
  reg unnamedbinop5540_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5540_delay1_validunnamednull0_CEprocess_CE <= {((unnamedcast5528USEDMULTIPLEcast)>=((16'd8)))}; end end
  wire [15:0] unnamedcast5534USEDMULTIPLEcast;assign unnamedcast5534USEDMULTIPLEcast = (unnamedcast5526USEDMULTIPLEcast[31:16]); 
  reg unnamedbinop5542_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5542_delay1_validunnamednull0_CEprocess_CE <= {((unnamedcast5534USEDMULTIPLEcast)>=((16'd2)))}; end end
  reg unnamedbinop5543_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5543_delay1_validunnamednull0_CEprocess_CE <= {(unnamedbinop5540_delay1_validunnamednull0_CEprocess_CE&&unnamedbinop5542_delay1_validunnamednull0_CEprocess_CE)}; end end
  reg unnamedbinop5545_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5545_delay1_validunnamednull0_CEprocess_CE <= {((unnamedcast5528USEDMULTIPLEcast)<((16'd648)))}; end end
  reg unnamedbinop5547_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5547_delay1_validunnamednull0_CEprocess_CE <= {((unnamedcast5534USEDMULTIPLEcast)<((16'd482)))}; end end
  reg unnamedbinop5548_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5548_delay1_validunnamednull0_CEprocess_CE <= {(unnamedbinop5545_delay1_validunnamednull0_CEprocess_CE&&unnamedbinop5547_delay1_validunnamednull0_CEprocess_CE)}; end end
  reg unnamedbinop5549_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop5549_delay1_validunnamednull0_CEprocess_CE <= {(unnamedbinop5543_delay1_validunnamednull0_CEprocess_CE&&unnamedbinop5548_delay1_validunnamednull0_CEprocess_CE)}; end end
  assign process_output = {unnamedbinop5549_delay1_validunnamednull0_CEprocess_CE,unnamedcast5522_delay3_validunnamednull0_CEprocess_CE};
endmodule