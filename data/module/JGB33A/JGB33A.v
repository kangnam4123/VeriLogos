module JGB33A(A1, A2, A3, B1, B2, B3, O);
input   A1;
input   A2;
input   A3;
input   B1;
input   B2;
input   B3;
output  O;
or g0(w0, A1, A2, A3);
or g1(w4, B1, B2, B3);
and g2(O, w0, w4);
endmodule