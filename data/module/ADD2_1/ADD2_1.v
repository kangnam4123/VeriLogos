module ADD2_1(A, B, CIN, S, C);
input   A;
input   B;
input   CIN;
output  S;
output  C;
xor g0(S, A, B, CIN);
and g1(w3, A, B);
or g2(w8, A, B);
and g3(w6, CIN, w8);
or g4(C, w3, w6);
endmodule