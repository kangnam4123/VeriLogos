module TLVDS_OBUF (I, O, OB);
  input I;
  output O;
  output OB;
  assign O = I;
  assign OB = ~I;
endmodule