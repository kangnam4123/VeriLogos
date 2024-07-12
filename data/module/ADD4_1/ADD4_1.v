module ADD4_1(X1, X2, X3, X4, CIN, S, C, COUT);
input   X1;
input   X2;
input   X3;
input   X4;
input   CIN;
output  S;
output  C;
output  COUT;
xor g0(S, X1, X2, X3, X4, CIN);
and g1(w8, X1, X2);
and g2(w11, X3, X4);
or g3(w7, w8, w11);
and g4(w5, CIN, w7);
xor g5(w15, CIN, X1);
not g6(w19, X3);
not g7(w20, X4);
and g8(w14, w15, X2, w19, w20);
not g9(w23, X1);
not g10(w24, X2);
xor g11(w25, X3, X4);
and g12(w21, CIN, w23, w24, w25);
not g13(w29, CIN);
xnor g14(w32, X1, X2);
and g15(w28, w29, X3, X4, w32);
not g16(w38, X3);
not g17(w39, X4);
and g18(w35, CIN, X1, w38, w39);
or g19(C, w5, w14, w21, w28, w35);
or g20(w40, X1, X2);
or g21(w43, X3, X4);
and g22(COUT, w40, w43);
endmodule