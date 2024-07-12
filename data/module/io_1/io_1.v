module io_1 (input OE, input I, output O, inout PAD);
   assign O = PAD;
   assign PAD = OE ? I : 1'bz;
endmodule