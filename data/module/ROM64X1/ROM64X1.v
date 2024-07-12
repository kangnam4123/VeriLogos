module ROM64X1 (
  output O,
  input A0, A1, A2, A3, A4, A5
);
  parameter [63:0] INIT = 64'h0;
  assign O = INIT[{A5, A4, A3, A2, A1, A0}];
endmodule