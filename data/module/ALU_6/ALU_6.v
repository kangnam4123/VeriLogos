module ALU_6(inputA, inputB, ALUop, result, zero);
input [31:0] inputA, inputB;
input [2:0] ALUop; 
output [31:0] result;
reg [31:0] result;
output zero;
reg zero;
always @(inputA or inputB or ALUop)
begin 
casez(ALUop)
  3'b110:  result = inputA - inputB;
  3'b010:  result = inputA + inputB;
  3'bz00:  result = inputA & inputB;
  3'b?01:  result = inputA | inputB;
  3'b?11: 
    if ( inputA - inputB >= 0 )
      result = 1;
    else
      result = 0;
  endcase
   if (inputA == inputB)
       zero = 1;
   else
       zero = 0;
end 
endmodule