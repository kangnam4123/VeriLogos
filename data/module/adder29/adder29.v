module adder29 ( CarryIn, x, y, z ) ;
   input CarryIn;
   input  [27:0] x, y ;
   output [28:0] z ;
   assign z = x[27:0] + y[27:0] + CarryIn ;
endmodule