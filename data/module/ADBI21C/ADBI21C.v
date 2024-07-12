module ADBI21C(A1, A2, B, O);
input   A1;
input   A2;
input   B;
output  O;
not g0(w2, A2);
and g1(w0, A1, w2);
or g2(O, w0, B);
endmodule