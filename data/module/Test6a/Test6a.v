module Test6a(input OE, inout [1:0] Z);
   assign Z = (OE) ? 2'b01 : 2'bzz;
endmodule