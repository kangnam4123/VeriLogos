module ANAND5C(A1, A2, A3, A4, A5, O);
input   A1;
input   A2;
input   A3;
input   A4;
input   A5;
output  O;
nand g0(O, A1, A2, A3, A4, A5);
endmodule