module Test5(input OE, inout Z6, inout Z7, inout Z8, inout Z9);
   assign Z6 = (OE) ? 1'b0 : 1'bz;
   assign Z7 = (OE) ? 1'b1 : 1'bz;
   assign Z8 = (OE) ? 1'bz : 1'b0;
   assign Z9 = (OE) ? 1'bz : 1'b1;
endmodule