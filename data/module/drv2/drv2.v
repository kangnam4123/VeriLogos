module drv2
  (input colSelA,
   input colSelB,
   output datao
   );
   assign datao = colSelB & colSelA;
endmodule