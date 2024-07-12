module mux_12 (input[1:0] A, input SEL, output Z);
   assign Z = (SEL) ? A[1] : 1'bz;
   assign Z = (!SEL)? A[0] : 1'bz;
   assign Z = 1'bz;
endmodule