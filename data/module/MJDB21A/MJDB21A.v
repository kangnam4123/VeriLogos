module MJDB21A(A1, A2, B, O);
input   A1;
input   A2;
input   B;
output  O;
and g0(w0, A1, A2);
or g1(O, w0, B);
endmodule