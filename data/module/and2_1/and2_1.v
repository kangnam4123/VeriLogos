module and2_1 (
   z,
   a, b
   );
  parameter DELAY = 1;
  input a,b;
  output z;
  assign #DELAY z= a & b;
endmodule