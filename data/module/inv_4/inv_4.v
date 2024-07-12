module inv_4 (
   zn,
   i
   );
  parameter DELAY = 1;
  input i;
  output zn;
  assign #DELAY zn = !i;
endmodule