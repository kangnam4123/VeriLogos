module DW01_add2_1 (A,B,CI,SUM,CO);
  parameter width=8'b00100100;
  output [width-1 : 0] SUM;
  output CO;
  input [width-1 : 0] A;
  input [width-1 : 0] B;
  input CI;
  wire [width-1 : 0] SUM;
  reg [width-2 : 0] sum_temp;
  reg CO;
  assign SUM = {CO, sum_temp};
always @(A or B or CI)
  begin
    {CO, sum_temp} = A+B+CI;
  end
endmodule