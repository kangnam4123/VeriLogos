module DELAY (A, Z);
  parameter delay = 10;
  input A;
  output Z;
  assign #delay Z = A;
endmodule