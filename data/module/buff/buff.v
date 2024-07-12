module buff (
   z,
   i
   );
  parameter DELAY = 1;
  input i;
  output z;
  assign #DELAY z = i;
endmodule