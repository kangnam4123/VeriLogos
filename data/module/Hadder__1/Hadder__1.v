module Hadder__1(
carry,
  sum,
  in2,
  in1
  );
  input in1, in2;
  output sum, carry;
  assign sum=in1^in2;
  assign carry=in1&in2;
endmodule