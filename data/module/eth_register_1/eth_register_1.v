module eth_register_1(DataIn, DataOut, Write, Clk, Reset, SyncReset);
parameter WIDTH = 8; 
parameter RESET_VALUE = 0;
input [WIDTH-1:0] DataIn;
input Write;
input Clk;
input Reset;
input SyncReset;
output [WIDTH-1:0] DataOut;
reg    [WIDTH-1:0] DataOut;
always @ (posedge Clk or posedge Reset)
begin
  if(Reset)
    DataOut<= RESET_VALUE;
  else
  if(SyncReset)
    DataOut<= RESET_VALUE;
  else
  if(Write)                         
    DataOut<= DataIn;
end
endmodule