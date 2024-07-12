module comparator_3(a, b, gt, lt, eq);
   input a, b;
   output gt, lt, eq;
   wire   a, b, not_a, not_b; 
   wire 	  gt, lt, eq; 
   not( not_a, a );
   not( not_b, b );
   xnor( eq, a, b );
   and( gt, a, not_b );
   and (lt, not_a, b);
endmodule