module ROM256X1 (
  output O,
  input A0, A1, A2, A3, A4, A5, A6, A7
);
  parameter [255:0] INIT = 256'h0;
  assign O = INIT[{A7, A6, A5, A4, A3, A2, A1, A0}];
endmodule