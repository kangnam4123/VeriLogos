module Test3(input OE, input A, inout Z3);
   assign Z3 = (OE) ? A : 1'bz;
   assign Z3 = 1'b1;
endmodule