module PADOUT (output padout, input padin, input oe);
   assign padout  = padin;
   assign oe = oe;
endmodule