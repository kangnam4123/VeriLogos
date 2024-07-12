module T_INV (
    input  TI,
    output TO
);
  assign TO = ~TI;
endmodule