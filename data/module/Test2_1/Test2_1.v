module Test2_1(input OE, input A, inout Z2);
   assign Z2 = (OE) ? A : 1'bz;
endmodule