module MUXF6(output O, input I0, I1, S);
  assign O = S ? I1 : I0;
endmodule