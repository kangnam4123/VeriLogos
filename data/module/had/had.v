module had (A, B,  C, S);
   input A, B;
   output C, S;
   xor s (S, A, B);
   and c (C, A, B);
endmodule