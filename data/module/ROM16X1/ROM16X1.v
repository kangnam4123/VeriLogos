module ROM16X1 (
  output O,
  input A0, A1, A2, A3
);
  parameter [15:0] INIT = 16'h0;
  assign O = INIT[{A3, A2, A1, A0}];
endmodule