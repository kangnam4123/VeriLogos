module JDB21X3A(A1, A2, B1, B2, B3, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   B3;
output  O;
and g0(w0, A1, A2);
or g1(O, w0, B1, B2, B3);
endmodule