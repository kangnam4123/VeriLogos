module MJGB31A(A1, A2, A3, B, O);
input   A1;
input   A2;
input   A3;
input   B;
output  O;
or g0(w0, A1, A2, A3);
and g1(O, w0, B);
endmodule