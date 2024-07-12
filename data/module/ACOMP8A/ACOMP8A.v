module ACOMP8A(A0, A1, A2, A3, A4, A5, A6, A7, B0, B1, B2, 
        B3, B4, B5, B6, B7, O);
input   A0;
input   A1;
input   A2;
input   A3;
input   A4;
input   A5;
input   A6;
input   A7;
input   B0;
input   B1;
input   B2;
input   B3;
input   B4;
input   B5;
input   B6;
input   B7;
output  O;
xor g0(w0, A0, B0);
xor g1(w3, A1, B1);
xor g2(w6, A2, B2);
xor g3(w9, A3, B3);
xor g4(w12, A4, B4);
xor g5(w15, A5, B5);
xor g6(w18, A6, B6);
xor g7(w21, A7, B7);
nor g8(O, w0, w3, w6, w9, w12, w15, w18, w21);
endmodule