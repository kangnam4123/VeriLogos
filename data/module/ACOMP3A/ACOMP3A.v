module ACOMP3A(A0, A1, A2, B0, B1, B2, O);
input   A0;
input   A1;
input   A2;
input   B0;
input   B1;
input   B2;
output  O;
xor g0(w0, A0, B0);
xor g1(w3, A1, B1);
xor g2(w6, A2, B2);
nor g3(O, w0, w3, w6);
endmodule