module smr_gate ( INA, INB, INC, PPBIT );
   input  INA;
   input  INB;
   input  INC;
   output PPBIT;
   assign PPBIT = ( ~ (INA & INB)) & INC;
endmodule