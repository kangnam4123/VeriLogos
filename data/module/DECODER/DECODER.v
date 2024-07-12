module DECODER ( INA, INB, INC, TWOPOS, TWONEG, ONEPOS, ONENEG );
input  INA;
input  INB;
input  INC;
output TWOPOS;
output TWONEG;
output ONEPOS;
output ONENEG;
   assign TWOPOS =  ~ ( ~ (INA & INB & ( ~ INC)));
   assign TWONEG =  ~ ( ~ (( ~ INA) & ( ~ INB) & INC));
   assign ONEPOS = (( ~ INA) & INB & ( ~ INC)) | (( ~ INC) & ( ~ INB) & INA);
   assign ONENEG = (INA & ( ~ INB) & INC) | (INC & INB & ( ~ INA));
endmodule