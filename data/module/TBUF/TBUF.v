module TBUF (O, I, OEN);
  input I, OEN;
  output O;
  assign O = OEN ? 1'bz : I;
endmodule