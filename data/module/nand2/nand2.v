module nand2 (
   zn,
   a, b
   );
   parameter DELAY = 1;
   input a,b;
   output zn;
   assign #DELAY zn= !(a & b);
endmodule