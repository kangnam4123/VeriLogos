module ResetToBool( RST, VAL);
   input  RST;
   output VAL;
   assign VAL = (RST == 1'b0);
endmodule