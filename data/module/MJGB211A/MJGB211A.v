module MJGB211A(A1, A2, B, C, O);
input   A1;
input   A2;
input   B;
input   C;
output  O;
and g0(w1, A1, A2);
or g1(w0, w1, B);
and g2(O, w0, C);
endmodule