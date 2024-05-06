module clockhdr
(
  TE,
  E,
  CP,
  Q
);
  input TE;
  input E;
  input CP;
  output Q;
  wire enable;
  assign enable = E | TE;
endmodule