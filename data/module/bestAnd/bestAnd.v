module bestAnd(inOne, inTwo, outResult);
  input inOne;
  input inTwo;
  output outResult;
  reg outResult;
  always @(*) begin
    outResult = inOne & inTwo;
  end
endmodule