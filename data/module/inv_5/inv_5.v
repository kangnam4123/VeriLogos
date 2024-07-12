module inv_5 (
    output Q,
    input  A
);
  assign Q = A ? 0 : 1;
endmodule