module ADBI122D(A1, A2, B1, B2, C, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   C;
output  O;
not g0(w2, A2);
and g1(w0, A1, w2);
and g2(w3, B1, B2);
or g3(O, w0, w3, C);
endmodule