module Test1(input OE, input A, inout Z1);
   assign Z1 = (OE) ? A : 1'bz;
endmodule