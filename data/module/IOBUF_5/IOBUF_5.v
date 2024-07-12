module IOBUF_5 ( input T, input I, output O, inout IO );
   assign O = IO;
   assign IO = T ? 1'bz : I;
endmodule