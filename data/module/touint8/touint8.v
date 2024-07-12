module touint8(input CLK, input process_CE, input [15:0] inp, output [7:0] process_output);
parameter INSTANCE_NAME="INST";
  reg [15:0] unnamedbinop1734_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop1734_delay1_validunnamednull0_CEprocess_CE <= {(inp>>>(16'd2))}; end end
  reg [15:0] unnamedcast1736_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast1736_delay1_validunnamednull0_CEprocess_CE <= (16'd255); end end
  reg unnamedbinop1737_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedbinop1737_delay1_validunnamednull0_CEprocess_CE <= {((unnamedbinop1734_delay1_validunnamednull0_CEprocess_CE)>(unnamedcast1736_delay1_validunnamednull0_CEprocess_CE))}; end end
  reg [7:0] unnamedcast1740_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast1740_delay1_validunnamednull0_CEprocess_CE <= (8'd255); end end
  reg [7:0] unnamedcast1740_delay2_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast1740_delay2_validunnamednull0_CEprocess_CE <= unnamedcast1740_delay1_validunnamednull0_CEprocess_CE; end end
  reg [7:0] unnamedcast1739_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedcast1739_delay1_validunnamednull0_CEprocess_CE <= unnamedbinop1734_delay1_validunnamednull0_CEprocess_CE[7:0]; end end
  reg [7:0] unnamedselect1741_delay1_validunnamednull0_CEprocess_CE;  always @ (posedge CLK) begin if (process_CE) begin unnamedselect1741_delay1_validunnamednull0_CEprocess_CE <= ((unnamedbinop1737_delay1_validunnamednull0_CEprocess_CE)?(unnamedcast1740_delay2_validunnamednull0_CEprocess_CE):(unnamedcast1739_delay1_validunnamednull0_CEprocess_CE)); end end
  assign process_output = unnamedselect1741_delay1_validunnamednull0_CEprocess_CE;
endmodule