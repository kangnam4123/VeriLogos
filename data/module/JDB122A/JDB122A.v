module JDB122A(A1, A2, B1, B2, C, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   C;
output  O;
and g0(w0, A1, A2);
and g1(w3, B1, B2);
or g2(O, w0, w3, C);
endmodule