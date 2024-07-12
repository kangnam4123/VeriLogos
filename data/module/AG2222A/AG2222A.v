module AG2222A(A1, A2, B1, B2, C1, C2, D1, D2, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   C1;
input   C2;
input   D1;
input   D2;
output  O;
or g0(w0, A1, A2);
or g1(w3, B1, B2);
or g2(w6, C1, C2);
or g3(w9, D1, D2);
nand g4(O, w0, w3, w6, w9);
endmodule