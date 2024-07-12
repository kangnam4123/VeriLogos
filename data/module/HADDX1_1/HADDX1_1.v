module HADDX1_1 (A0,B0,SO,C1);
output  SO,C1;
input   A0,B0;
xor  #1  (SO,B0,A0);
and  #1  (C1,B0,A0);
endmodule