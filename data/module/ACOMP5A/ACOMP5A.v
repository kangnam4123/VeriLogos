module ACOMP5A(A0, A1, A2, A3, A4, B0, B1, B2, B3, B4, O);
input   A0;
input   A1;
input   A2;
input   A3;
input   A4;
input   B0;
input   B1;
input   B2;
input   B3;
input   B4;
output  O;
xor g0(w0, A0, B0);
xor g1(w3, A1, B1);
xor g2(w6, A2, B2);
xor g3(w9, A3, B3);
xor g4(w12, A4, B4);
nor g5(O, w0, w3, w6, w9, w12);
endmodule