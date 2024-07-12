module mux2x5 (op0, op1, select, result);
input [5:0] op0, op1;
input select;
output [5:0] result;
assign result = select? op1: op0;
endmodule