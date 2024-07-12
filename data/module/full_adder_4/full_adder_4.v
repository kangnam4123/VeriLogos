module full_adder_4
(
  input A,
  input B,
  input CARRY_IN,
  output SUM,
  output CARRY_OUT
);
  wire tmpSum;
  wire tmp1;
  wire tmp1n;
  wire tmp2;
  wire tmp2n;
  wire tmp3;
  wire tmp4;
  wire tmp5;
  wire tmp6;
  xor A1 (tmpSum, A, B);
  xor A2 (SUM, CARRY_IN, tmpSum);
  not B1N (tmp1n, B);
  and B1 (tmp1, A, tmp1n);
  not B2N (tmp2n, A);
  and B2 (tmp2, tmp2n, B);
  and B3 (tmp3, A, B);
  and B4 (tmp4, tmp1, CARRY_IN);
  and B5 (tmp5, tmp2, CARRY_IN);
  or B6 (tmp6, tmp4, tmp5);
  or B7 (CARRY_OUT, tmp6, tmp3);
endmodule