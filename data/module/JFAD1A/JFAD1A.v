module JFAD1A(A, B, CI, S, CO);
input   A;
input   B;
input   CI;
output  S;
output  CO;
xor g0(S, A, B, CI);
and g1(w3, A, B);
or g2(w8, A, B);
and g3(w6, CI, w8);
or g4(CO, w3, w6);
endmodule