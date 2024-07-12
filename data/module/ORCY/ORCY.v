module ORCY (output O, input CI, I);
  assign O = CI | I;
endmodule