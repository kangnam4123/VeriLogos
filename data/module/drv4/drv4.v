module drv4
  (input colSelA,
   input colSelB,
   input colSelC,
   input colSelD,
   output datao
   );
   assign datao = colSelB & colSelA & colSelC & colSelD;
endmodule