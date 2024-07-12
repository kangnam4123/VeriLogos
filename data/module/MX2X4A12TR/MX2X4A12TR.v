module MX2X4A12TR (A, B, S0, Y);
  input A, B, S0;
  output Y;
  wire N3, N6;
  and C1 (N3, S0, B);
  and C3 (N6, S0__br_in_not, A);
  not (S0__br_in_not, S0);
  or C4 (Y, N3, N6);
endmodule