module BLOCK0 ( A, B, PHI, POUT, GOUT );
input  A;
input  B;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (A | B);
   assign GOUT =  ~ (A & B);
endmodule