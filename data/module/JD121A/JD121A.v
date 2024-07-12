module JD121A(A1, A2, B, C, O);
input   A1;
input   A2;
input   B;
input   C;
output  O;
or g0(w1, A1, A2);
and g1(w0, w1, B);
nor g2(O, w0, C);
endmodule