module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;
  wire  a, b, ci, sum, co,
        n1, n2, n3;
  xor    #1 (n1, a, b);
  and    #2 (n2, a, b);
  and    #3 (n3, n1, ci);
  xor    #4 (sum, n1, ci);
  or     #4 (co, n2, n3);
endmodule