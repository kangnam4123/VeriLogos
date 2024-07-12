module MJDB222A(A1, A2, B1, B2, C1, C2, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   C1;
input   C2;
output  O;
and g0(w0, A1, A2);
and g1(w3, B1, B2);
and g2(w6, C1, C2);
or g3(O, w0, w3, w6);
endmodule