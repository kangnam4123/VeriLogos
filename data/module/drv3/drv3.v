module drv3
  (input colSelA,
   input colSelB,
   input colSelC,
   output datao
   );
   assign datao = colSelB & colSelA & colSelC;
endmodule