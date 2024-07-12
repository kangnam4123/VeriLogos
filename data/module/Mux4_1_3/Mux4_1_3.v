module Mux4_1_3(
input  [2:0]Data0,Data1,Data2,Data3,
input [1:0] Sel,
output [2:0]Data
);
assign Data = (Sel[1] == 1'b0)?((Sel[0] == 1'b0)?(Data0):(Data1)):((Sel[0] == 1'b0)?(Data2):(Data3));
endmodule