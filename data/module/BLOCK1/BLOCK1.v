module BLOCK1 ( PIN1, PIN2, GIN1, GIN2, PHI, POUT, GOUT );
input  PIN1;
input  PIN2;
input  GIN1;
input  GIN2;
input  PHI;
output POUT;
output GOUT;
   assign POUT =  ~ (PIN1 | PIN2);
   assign GOUT =  ~ (GIN2 & (PIN2 | GIN1));
endmodule