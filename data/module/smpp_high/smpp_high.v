module smpp_high ( ONEPOS, ONENEG, TWOPOS, TWONEG, INA, INB, PPBIT );
   input  ONEPOS;
   input  ONENEG;
   input  TWOPOS;
   input  TWONEG;
   input  INA;
   input  INB;
   output PPBIT;
   assign PPBIT =  ~ ((INA & ONEPOS) | (INB & ONENEG) | (INA & TWOPOS) | (INB & TWONEG));
endmodule